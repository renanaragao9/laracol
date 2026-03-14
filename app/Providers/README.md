# Providers | Provedores

📋 **Português BR:** Providers são programas COBOL que inicializam e configuram serviços da aplicação. Eles são executados durante o bootstrap da aplicação.

📋 **English:** Providers are COBOL programs that initialize and configure application services. They are executed during application bootstrap.

---

## Português BR - Guia de Uso

### O que é um Provider?

Um Provider é um programa COBOL que configura e inicializa um serviço da aplicação. É o lugar ideal para registrar bindings, configurar dependências e realizar inicializações globais.

### Exemplo de Criar um Provider

Para criar um novo provider chamado `DatabaseProvider.cbl`:

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. DATABASEPROVIDER.

      *> Comentário: Provider para configuração de banco de dados
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 DB-CONNECTION PIC X(100).
       01 DB-HOST PIC X(50) VALUE "localhost".
       01 DB-PORT PIC 9(4) VALUE 5432.
       01 DB-NAME PIC X(50) VALUE "laracol_db".
       01 DB-USER PIC X(50) VALUE "postgres".
       01 DB-PASSWORD PIC X(50) VALUE "password".
       01 IS-CONNECTED PIC X VALUE 'N'.

       LINKAGE SECTION.
       01 RESULT-STATUS PIC X(50).

       PROCEDURE DIVISION USING RESULT-STATUS.

      *> Comentário: Conecta ao banco de dados
           DISPLAY "Inicializando banco de dados..."
           DISPLAY "Host: " & DB-HOST
           DISPLAY "Porta: " & DB-PORT
           DISPLAY "Banco: " & DB-NAME

           MOVE 'Y' TO IS-CONNECTED
           MOVE "Database connected" TO RESULT-STATUS

           DISPLAY "✓ Banco de dados inicializado com sucesso"

           GOBACK.
```

### Tipos de Providers

1. **DatabaseProvider**: Configura conexão com banco de dados
2. **CacheProvider**: Configura sistema de cache
3. **AuthProvider**: Configura autenticação
4. **LogProvider**: Configura sistema de logs
5. **ConfigProvider**: Carrega configurações

### Estrutura Recomendada

```
Providers/
├── AppBootstrap.cbl (iniciador principal)
├── DatabaseProvider.cbl
├── CacheProvider.cbl
├── AuthProvider.cbl
└── README.md (este arquivo)
```

### Ordem de Execução

Os providers são executados na seguinte ordem:

1. ConfigProvider (carrega configurações)
2. DatabaseProvider (conecta banco de dados)
3. CacheProvider (inicializa cache)
4. AuthProvider (configura autenticação)
5. Outros providers customizados

---

## English - Usage Guide

### What is a Provider?

A Provider is a COBOL program that configures and initializes an application service. It is the ideal place to register bindings, configure dependencies, and perform global initializations.

### Example of Creating a Provider

To create a new provider called `CacheProvider.cbl`:

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CACHEPROVIDER.

      *> Comment in English: Provider for cache configuration
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 CACHE-DRIVER PIC X(20) VALUE "redis".
       01 CACHE-HOST PIC X(50) VALUE "localhost".
       01 CACHE-PORT PIC 9(4) VALUE 6379.
       01 CACHE-TTL PIC 9(4) VALUE 3600.
       01 IS-INITIALIZED PIC X VALUE 'N'.

       LINKAGE SECTION.
       01 RESULT-STATUS PIC X(50).

       PROCEDURE DIVISION USING RESULT-STATUS.

      *> Comment: Initialize cache service
           DISPLAY "Initializing cache service..."
           DISPLAY "Driver: " & CACHE-DRIVER
           DISPLAY "Host: " & CACHE-HOST
           DISPLAY "Port: " & CACHE-PORT

           MOVE 'Y' TO IS-INITIALIZED
           MOVE "Cache initialized" TO RESULT-STATUS

           DISPLAY "✓ Cache service initialized successfully"

           GOBACK.
```

### Types of Providers

1. **DatabaseProvider**: Configures database connection
2. **CacheProvider**: Configures caching system
3. **AuthProvider**: Configures authentication
4. **LogProvider**: Configures logging system
5. **ConfigProvider**: Loads application configuration

### Recommended Structure

```
Providers/
├── AppBootstrap.cbl (main initializer)
├── DatabaseProvider.cbl
├── CacheProvider.cbl
├── AuthProvider.cbl
└── README.md (this file)
```

### Execution Order

Providers are executed in the following order:

1. ConfigProvider (loads configuration)
2. DatabaseProvider (connects to database)
3. CacheProvider (initializes cache)
4. AuthProvider (configures authentication)
5. Other custom providers

---

## AppBootstrap.cbl | Inicializador Principal

O arquivo `AppBootstrap.cbl` é responsável por chamar todos os providers:

The `AppBootstrap.cbl` file is responsible for calling all providers:

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. APPBOOTSTRAP.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 STATUS PIC X(50).

       PROCEDURE DIVISION.
           CALL "DATABASEPROVIDER" USING STATUS
           DISPLAY "Database: " & STATUS

           CALL "CACHEPROVIDER" USING STATUS
           DISPLAY "Cache: " & STATUS

           CALL "AUTHPROVIDER" USING STATUS
           DISPLAY "Auth: " & STATUS

           GOBACK.
```
