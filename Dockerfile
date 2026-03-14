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

# Instalar runtime
RUN apt-get update && apt-get install -y --no-install-recommends \
    gnucobol \
    libdb5.3 \
    python3 \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Diretório de trabalho
WORKDIR /app

# Copiar aplicação compilada do builder
COPY --from=builder /app/bin /app/bin
COPY --from=builder /app/public /app/public
COPY --from=builder /app/config /app/config
COPY --from=builder /app/bootstrap /app/bootstrap
COPY --from=builder /app/app /app/app
COPY --from=builder /app/routes /app/routes
COPY --from=builder /app/storage /app/storage
COPY --from=builder /app/laracol /app/laracol

# Criar diretórios essenciais
RUN mkdir -p /app/storage/logs && \
    chmod 755 /app/bin/api && \
    chmod 755 /app/laracol

# Expor porta
EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8000/ || exit 1

# Iniciar servidor Laracol
CMD ["./laracol", "serve", "8000"]
