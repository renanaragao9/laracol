# Stage 1: Build
FROM debian:bookworm-slim as builder

LABEL maintainer="Dev Team"
LABEL description="Laracol Framework - API REST em COBOL"

# Fix repositórios e atualizar
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Instalar dependências de build
RUN apt-get update && apt-get install -y --no-install-recommends \
    gnucobol \
    make \
    curl \
    git \
    build-essential \
    libdb-dev \
    && rm -rf /var/lib/apt/lists/*

# Definir diretório de trabalho
WORKDIR /app

# Copiar arquivos do projeto
COPY . .

# Compilar aplicação
RUN make clean && make build

# Stage 2: Runtime
FROM debian:bookworm-slim

LABEL maintainer="Dev Team"
LABEL description="Laracol Framework - Runtime"

# Fix repositórios e atualizar
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Instalar runtime e servidor web
RUN apt-get update && apt-get install -y --no-install-recommends \
    gnucobol \
    libdb5.3 \
    apache2 \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Habilitar módulos Apache necessários
RUN a2enmod cgi && \
    a2enmod rewrite && \
    a2enmod headers || true

# Diretório de trabalho
WORKDIR /app

# Copiar aplicação compilada do builder
COPY --from=builder /app/bin /app/bin
COPY --from=builder /app/public /var/www/html

# Copiar arquivo de configuração do Apache
COPY --from=builder /app/config /app/config

# Criar diretórios essenciais
RUN mkdir -p /app/storage/logs && \
    chmod 755 /app/bin/api 2>/dev/null || true && \
    chmod 755 /var/www/html 2>/dev/null || true

# Configurar Apache para CGI (usando tee)
RUN cat > /etc/apache2/sites-available/laracol.conf << 'EOF'
<VirtualHost *:80>
ServerName localhost
DocumentRoot /var/www/html
<Directory /var/www/html>
Options +ExecCGI +FollowSymLinks
AddHandler cgi-script .cgi
AllowOverride All
Require all granted
</Directory>
ErrorLog ${APACHE_LOG_DIR}/error.log
CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

RUN a2dissite 000-default && \
    a2ensite laracol.conf

# Expor porta
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Iniciar Apache
CMD ["apache2ctl", "-D", "FOREGROUND"]
