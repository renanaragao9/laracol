#!/bin/bash

# Entry point CGI para a API COBOL
# Este script é executado pelo servidor web (Apache/Nginx)

# Diretório da aplicação
APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Compilar e executar a aplicação
export APP_ENV=production
$APP_DIR/bin/api

# Saída esperada em JSON para o servidor web
