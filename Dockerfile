# Stage 1: Build
FROM debian:bullseye-slim as builder

LABEL maintainer="Dev Team"
LABEL description="Laracol Framework - API REST em COBOL"

# Instalar dependências de build
RUN apt-get update && apt-get install -y \
    gnucobol \
    make \
    curl \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Definir diretório de trabalho
WORKDIR /app

# Copiar arquivos do projeto
COPY . .

# Compilar aplicação
RUN make clean && make build

# Stage 2: Runtime
FROM debian:bullseye-slim

LABEL maintainer="Dev Team"
LABEL description="Laracol Framework - Runtime"

# Instalar runtime e servidor web
RUN apt-get update && apt-get install -y \
    gnucobol \
    apache2 \
    apache2-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Habilitar módulos Apache necessários
RUN a2enmod cgi && \
    a2enmod rewrite && \
    a2enmod headers

# Diretório de trabalho
WORKDIR /app

# Copiar aplicação compilada do builder
COPY --from=builder /app/bin /app/bin
COPY --from=builder /app/public /var/www/html

# Copiar arquivo de configuração do Apache
COPY --from=builder /app/config /app/config

# Criar diretórios essenciais
RUN mkdir -p /app/storage/logs && \
    chmod 755 /app/bin/api && \
    chmod 755 /var/www/html

# Configurar Apache para CGI
RUN echo '<VirtualHost *:80>' > /etc/apache2/sites-available/laracol.conf && \
    echo '  ServerName localhost' >> /etc/apache2/sites-available/laracol.conf && \
    echo '  DocumentRoot /var/www/html' >> /etc/apache2/sites-available/laracol.conf && \
    echo '  <Directory /var/www/html>' >> /etc/apache2/sites-available/laracol.conf && \
    echo '    Options +ExecCGI +FollowSymLinks' >> /etc/apache2/sites-available/laracol.conf && \
    echo '    AddHandler cgi-script .cgi' >> /etc/apache2/sites-available/laracol.conf && \
    echo '    AllowOverride All' >> /etc/apache2/sites-available/laracol.conf && \
    echo '    Require all granted' >> /etc/apache2/sites-available/laracol.conf && \
    echo '  </Directory>' >> /etc/apache2/sites-available/laracol.conf && \
    echo '</VirtualHost>' && \
    a2dissite 000-default && \
    a2ensite laracol.conf

# Expor porta
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Iniciar Apache
CMD ["apache2ctl", "-D", "FOREGROUND"]
