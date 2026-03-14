# Bootstrap | Inicialização

📋 **Português BR:** Diretório responsável pela inicialização da aplicação Laracol. Contém o arquivo principal que inicia o framework.

📋 **English:** Directory responsible for initializing the Laracol application. Contains the main file that starts the framework.

---

## Português BR - Processo de Bootstrap

### Arquivo Principal: app.cbl

O arquivo `app.cbl` é o ponto de entrada da aplicação. Ele é responsável por:

1. **Carregar Configurações**: Lê variáveis de ambiente e arquivos de config
2. **Inicializar Providers**: Executa todos os providers de serviço
3. **Iniciar o Kernel HTTP**: Inicia o servidor HTTP
4. **Registrar Rotas**: Carrega todas as rotas da API

### Exemplo de app.cbl

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. LARACOLAPP.

      *> Comentário: Arquivo principal de bootstrap
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 APP-NAME PIC X(20) VALUE "Laracol".
       01 APP-VERSION PIC X(10) VALUE "1.0.0".
       01 ENVIRONMENT PIC X(20) VALUE "development".
       01 STATUS PIC X(50).

       PROCEDURE DIVISION.

      *> Comentário: Banner de inicialização
           DISPLAY " "
           DISPLAY "╔═══════════════════════════════════╗"
           DISPLAY "║         LARACOL FRAMEWORK         ║"
           DISPLAY "║ Uma API REST em COBOL Moderno     ║"
           DISPLAY "╚═══════════════════════════════════╝"
           DISPLAY " "

      *> Comentário: Carrega configurações
           DISPLAY "Carregando configurações..."
           PERFORM LOAD-CONFIG

      *> Comentário: Inicializa providers
           DISPLAY "Inicializando providers..."
           CALL "APPBOOTSTRAP" USING STATUS

      *> Comentário: Inicia servidor
           DISPLAY "Iniciando servidor HTTP..."
           CALL "HTTPKERNEL"

           DISPLAY " "
           DISPLAY "✓ Aplicação finalizada com sucesso"

           GOBACK.

       LOAD-CONFIG.
           DISPLAY "✓ Config carregada"
           DISPLAY "Ambiente: " & ENVIRONMENT.
```

### Sequência de Inicialização

1. **Config**: Carrega variáveis de ambiente
2. **Providers**: Executa DatabaseProvider, CacheProvider, etc
3. **Kernel**: Inicia servidor HTTP na porta configurada
4. **Routes**: Registra todas as rotas
5. **Listening**: Servidor pronto para receber requisições

### Arquivo de Configuração

```cobol
       01 DB-HOST PIC X(50) VALUE "localhost".
       01 DB-PORT PIC 9(4) VALUE 5432.
       01 HTTP-PORT PIC 9(4) VALUE 8080.
       01 APP-DEBUG PIC X VALUE 'Y'.
       01 APP-LOG-LEVEL PIC X(20) VALUE "info".
```

---

## English - Bootstrap Process

### Main File: app.cbl

The `app.cbl` file is the application entry point. It is responsible for:

1. **Load Configuration**: Reads environment variables and config files
2. **Initialize Providers**: Executes all service providers
3. **Start HTTP Kernel**: Starts the HTTP server
4. **Register Routes**: Loads all API routes

### Example of app.cbl

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. LARACOLAPP.

      *> Comment: Main bootstrap file
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 APP-NAME PIC X(20) VALUE "Laracol".
       01 APP-VERSION PIC X(10) VALUE "1.0.0".
       01 ENVIRONMENT PIC X(20) VALUE "production".
       01 STATUS PIC X(50).

       PROCEDURE DIVISION.

      *> Comment: Startup banner
           DISPLAY " "
           DISPLAY "╔═══════════════════════════════════╗"
           DISPLAY "║         LARACOL FRAMEWORK         ║"
           DISPLAY "║ A Modern REST API in COBOL        ║"
           DISPLAY "╚═══════════════════════════════════╝"
           DISPLAY " "

      *> Comment: Load configuration
           DISPLAY "Loading configuration..."
           PERFORM LOAD-CONFIG

      *> Comment: Initialize providers
           DISPLAY "Initializing providers..."
           CALL "APPBOOTSTRAP" USING STATUS

      *> Comment: Start server
           DISPLAY "Starting HTTP server..."
           CALL "HTTPKERNEL"

           DISPLAY " "
           DISPLAY "✓ Application shutting down gracefully"

           GOBACK.

       LOAD-CONFIG.
           DISPLAY "✓ Configuration loaded"
           DISPLAY "Environment: " & ENVIRONMENT.
```

### Initialization Sequence

1. **Config**: Loads environment variables
2. **Providers**: Executes DatabaseProvider, CacheProvider, etc
3. **Kernel**: Starts HTTP server on configured port
4. **Routes**: Registers all routes
5. **Listening**: Server ready to receive requests

### Configuration File

```cobol
       01 DB-HOST PIC X(50) VALUE "localhost".
       01 DB-PORT PIC 9(4) VALUE 5432.
       01 HTTP-PORT PIC 9(4) VALUE 8080.
       01 APP-DEBUG PIC X VALUE 'Y'.
       01 APP-LOG-LEVEL PIC X(20) VALUE "debug".
```

---

## Estrutura de Inicialização | Initialization Structure

```
bootstrap/
├── app.cbl (entrada principal)
└── README.md (este arquivo)
```

O bootstrap é executado via Makefile:  
Bootstrap is executed via Makefile:

```bash
make setup    # Configuração inicial | Initial setup
make build    # Compilar | Compile
make run      # Executar | Execute
```
