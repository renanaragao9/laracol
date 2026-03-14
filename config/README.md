# Config | Configuração

📋 **Português BR:** Diretório com arquivos de configuração da aplicação. Contém variáveis de ambiente e configurações específicas do contexto.

📋 **English:** Directory with application configuration files. Contains environment variables and context-specific configurations.

---

## Português BR - Arquivos de Configuração

### Estrutura de Configuração

```
config/
├── app.conf         - Configurações gerais
├── database.conf    - Configurações de banco de dados
└── README.md        - Este arquivo
```

### app.conf - Configurações Gerais

Arquivo de configuração principal da aplicação:

```cobol
       *> Comentário: Configurações de aplicação
       01 APP-CONFIG.
           05 APP-NAME PIC X(50) VALUE "Laracol".
           05 APP-VERSION PIC X(20) VALUE "1.0.0".
           05 APP-ENV PIC X(20) VALUE "development".
           05 APP-DEBUG PIC X VALUE 'Y'.
           05 APP-LOG-LEVEL PIC X(20) VALUE "debug".
           05 APP-TIMEZONE PIC X(20) VALUE "America/Sao_Paulo".

           05 HTTP-CONFIG.
               10 HTTP-HOST PIC X(50) VALUE "0.0.0.0".
               10 HTTP-PORT PIC 9(4) VALUE 8080.
               10 HTTP-TIMEOUT PIC 9(4) VALUE 30.

           05 CACHE-CONFIG.
               10 CACHE-DRIVER PIC X(20) VALUE "redis".
               10 CACHE-TTL PIC 9(5) VALUE 3600.

           05 LOG-CONFIG.
               10 LOG-PATH PIC X(100) VALUE "storage/logs".
               10 LOG-MAX-SIZE PIC 9(7) VALUE 10485760.
```

### database.conf - Configuração de Banco de Dados

Arquivo de configuração para conexão com banco de dados:

```cobol
       *> Comentário: Configurações de banco de dados
       01 DATABASE-CONFIG.
           05 DB-DEFAULT PIC X(20) VALUE "sqlite".

           05 SQLITE-CONFIG.
               10 SQLITE-PATH PIC X(100) VALUE "database/app.db".

           05 POSTGRES-CONFIG.
               10 DB-HOST PIC X(50) VALUE "localhost".
               10 DB-PORT PIC 9(4) VALUE 5432.
               10 DB-NAME PIC X(50) VALUE "laracol_db".
               10 DB-USER PIC X(50) VALUE "postgres".
               10 DB-PASSWORD PIC X(100) VALUE "password".
               10 DB-CHARSET PIC X(20) VALUE "utf8".
               10 DB-POOL-SIZE PIC 9(3) VALUE 10.

           05 MYSQL-CONFIG.
               10 DB-HOST PIC X(50) VALUE "localhost".
               10 DB-PORT PIC 9(4) VALUE 3306.
               10 DB-NAME PIC X(50) VALUE "laracol_db".
               10 DB-USER PIC X(50) VALUE "root".
               10 DB-PASSWORD PIC X(100) VALUE "password".
```

### Como Usar Configurações no Código

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CONFIGEXAMPLE.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 APP-CONFIG.
           05 APP-NAME PIC X(50).
           05 HTTP-PORT PIC 9(4).
           05 DB-HOST PIC X(50).

       PROCEDURE DIVISION.

      *> Comentário: Lê configurações e as utiliza
           MOVE "Laracol" TO APP-NAME
           MOVE 8080 TO HTTP-PORT
           MOVE "localhost" TO DB-HOST

           DISPLAY "App: " & APP-NAME
           DISPLAY "Port: " & HTTP-PORT
           DISPLAY "Database Host: " & DB-HOST

           GOBACK.
```

---

## English - Configuration Files

### Configuration Structure

```
config/
├── app.conf         - General configurations
├── database.conf    - Database configurations
└── README.md        - This file
```

### app.conf - General Configuration

Main application configuration file:

```cobol
       *> Comment: Application configurations
       01 APP-CONFIG.
           05 APP-NAME PIC X(50) VALUE "Laracol".
           05 APP-VERSION PIC X(20) VALUE "1.0.0".
           05 APP-ENV PIC X(20) VALUE "production".
           05 APP-DEBUG PIC X VALUE 'N'.
           05 APP-LOG-LEVEL PIC X(20) VALUE "warning".
           05 APP-TIMEZONE PIC X(20) VALUE "America/Sao_Paulo".

           05 HTTP-CONFIG.
               10 HTTP-HOST PIC X(50) VALUE "0.0.0.0".
               10 HTTP-PORT PIC 9(4) VALUE 8080.
               10 HTTP-TIMEOUT PIC 9(4) VALUE 30.

           05 SESSION-CONFIG.
               10 SESSION-DRIVER PIC X(20) VALUE "file".
               10 SESSION-LIFETIME PIC 9(4) VALUE 120.

           05 QUEUE-CONFIG.
               10 QUEUE-DRIVER PIC X(20) VALUE "sync".
```

### database.conf - Database Configuration

Configuration file for database connection:

```cobol
       *> Comment: Database configurations
       01 DATABASE-CONFIG.
           05 DB-DEFAULT PIC X(20) VALUE "sqlite".

           05 POSTGRES-CONFIG.
               10 DB-HOST PIC X(50) VALUE "localhost".
               10 DB-PORT PIC 9(4) VALUE 5432.
               10 DB-NAME PIC X(50) VALUE "laracol_db".
               10 DB-USER PIC X(50) VALUE "postgres".
               10 DB-PASSWORD PIC X(100) VALUE "password".
               10 DB-CHARSET PIC X(20) VALUE "utf8".
               10 DB-POOL-SIZE PIC 9(3) VALUE 10.
               10 DB-SSL PIC X VALUE 'N'.

           05 MYSQL-CONFIG.
               10 DB-HOST PIC X(50) VALUE "localhost".
               10 DB-PORT PIC 9(4) VALUE 3306.
               10 DB-NAME PIC X(50) VALUE "laracol_db".
               10 DB-USER PIC X(50) VALUE "root".
               10 DB-PASSWORD PIC X(100) VALUE "password".
               10 DB-CHARSET PIC X(20) VALUE "utf8mb4".
```

### How to Use Configuration in Code

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CONFIGEXAMPLE.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 APP-CONFIG.
           05 APP-NAME PIC X(50).
           05 HTTP-PORT PIC 9(4).
           05 DB-HOST PIC X(50).

       PROCEDURE DIVISION.

      *> Comment: Reads and uses configurations
           MOVE "Laracol" TO APP-NAME
           MOVE 8080 TO HTTP-PORT
           MOVE "localhost" TO DB-HOST

           DISPLAY "App: " & APP-NAME
           DISPLAY "Port: " & HTTP-PORT
           DISPLAY "Database Host: " & DB-HOST

           GOBACK.
```

---

## Variáveis de Ambiente | Environment Variables

Para alternar entre ambientes, use variáveis de ambiente:

To switch between environments, use environment variables:

```bash
# Português - Português BR
export APP_ENV=production
export APP_DEBUG=false
export LOG_LEVEL=error

# English - American English
export APP_ENV=production
export APP_DEBUG=false
export LOG_LEVEL=error
```

## Padrão de Nomes | Naming Pattern

- Use UPPERCASE para variáveis de configuração
- Separe palavras com underscore (\_)
- Exemplo: `DATABASE_HOST`, `HTTP_PORT`

Use UPPERCASE for configuration variables  
Separate words with underscore (\_)  
Example: `DATABASE_HOST`, `HTTP_PORT`
