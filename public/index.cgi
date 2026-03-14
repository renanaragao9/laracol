#!/bin/bash

# Entry point CGI para a API COBOL
# Este script é executado pelo servidor web (Apache/Nginx)

APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ "$REQUEST_URI" = "/" ] || [ "$REQUEST_URI" = "" ]; then
    echo "Content-Type: text/html; charset=utf-8"
    echo ""
    cat "$(dirname "${BASH_SOURCE[0]}")/interface.html"
else
    export APP_ENV=production
    $APP_DIR/bin/api
fi
