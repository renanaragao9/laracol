# 🐳 Docker - Laracol Framework

Guia rápido para executar o Laracol em containers Docker.

## Pré-requisitos

- [Docker](https://docs.docker.com/get-docker/) (v20+)
- [Docker Compose](https://docs.docker.com/compose/install/) (v1.29+)

## Iniciar o Projeto

### Opção 1: Docker Compose (Recomendado)

```bash
# Build e inicia o container
docker-compose up -d

# Acessar aplicação
curl http://localhost:8080

# Ver logs
docker-compose logs -f laracol

# Parar container
docker-compose down
```

### Opção 2: Apenas Docker

```bash
# Build da imagem
docker build -t laracol:latest .

# Executar container
docker run -d \
  --name laracol-api \
  -p 8080:80 \
  -v $(pwd)/storage/logs:/app/storage/logs \
  laracol:latest

# Acessar
curl http://localhost:8080

# Parar
docker stop laracol-api
docker rm laracol-api
```

## Comandos Úteis

```bash
# Entrar no container
docker-compose exec laracol bash

# Recompilar aplicação dentro do container
docker-compose exec laracol make clean && make build

# Visualizar porta mapeada
docker-compose port laracol 80

# Remover imagem
docker rmi laracol:latest

# Limpar sistema (cuidado!)
docker system prune -a
```

## Estrutura

- **Dockerfile**: Build em 2 estágios (builder + runtime)
  - Estágio 1: Compila COBOL com GnuCOBOL e Make
  - Estágio 2: Runtime leve com Apache CGI

- **docker-compose.yml**: Orquestração com:
  - Mapping de porta 80 → 8080
  - Volumes para logs e código
  - Health check automático
  - Environment variables

- **.dockerignore**: Otimiza build excluindo arquivos desnecessários

## Variáveis de Ambiente

- `APP_ENV`: development | production (default: development)
- `APP_DEBUG`: true | false (default: true)
- `LOG_LEVEL`: debug | info | warning | error (default: debug)

## Acesso

- **URL**: http://localhost:8080
- **Logs**: `docker-compose logs -f laracol`
- **Shell**: `docker-compose exec laracol bash`

## Troubleshooting

### Container não inicia

```bash
docker-compose logs laracol
docker-compose up --build
```

### Erro de permissão

```bash
sudo chown -R $USER:$USER storage/
chmod -R 755 storage/
```

### Porta 8080 já em uso

```bash
# Mudar no docker-compose.yml para outra porta
ports:
  - "8000:80"  # ou outra porta
```

## Produção

Para ambiente de produção:

1. Use imagem de produção (sem debug)
2. Configure variáveis `.env`
3. Use volume externo para logs
4. Configure HTTPS/SSL
5. Configure backup automático

```bash
# Build com tag apropriada
docker build -t laracol:1.0.0 .

# Push para registry
docker tag laracol:1.0.0 seu-registry/laracol:1.0.0
docker push seu-registry/laracol:1.0.0
```

## Multi-stage Build

O Dockerfile usa multi-stage para reduzir tamanho da imagem:

- **Stage 1 (builder)**: ~800MB (com compilador)
- **Stage 2 (runtime)**: ~400MB (só runtime)

Resultado final: ~400MB de imagem ligera e eficiente.
