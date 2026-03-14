# Http | Http

📋 **Português BR:** Este diretório contém a camada HTTP da aplicação Laracol, incluindo controllers, middleware e a configuração central do kernel HTTP.

📋 **English:** This directory contains the HTTP layer of the Laracol application, including controllers, middleware, and the central HTTP kernel configuration.

---

## Português BR - Estrutura do Diretório

### Componentes Principais

- **Controllers/**: Contém todos os controladores da API REST
- **Middleware/**: Contém programas que processam requisições HTTP
- **Kernel.cbl**: Arquivo central que configura e inicia o servidor HTTP

### Arquivo Kernel.cbl

O arquivo `Kernel.cbl` é o coração do sistema HTTP. Ele define:

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. HTTPKERNEL.

      *> Comentário: Kernel central do HTTP
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 SERVER-PORT PIC 9(4) VALUE 8080.
       01 SERVER-HOST PIC X(20) VALUE "localhost".
       01 IS-RUNNING PIC X VALUE 'Y'.

       PROCEDURE DIVISION.

      *> Comentário: Inicia o servidor HTTP
           DISPLAY "Iniciando servidor em " & SERVER-HOST & ":" & SERVER-PORT

           PERFORM UNTIL IS-RUNNING = 'N'
               DISPLAY "Aguardando requisições..."
               CALL "PROCESS-REQUEST"
           END-PERFORM

           GOBACK.
```

### Fluxo de Requisições

```
1. Cliente faz requisição HTTP
   ↓
2. Kernel.cbl recebe a requisição
   ↓
3. Middleware processa (autenticação, validação, etc)
   ↓
4. Controller apropriado é chamado
   ↓
5. Resposta é retornada ao cliente
```

### Exemplo de Criar um Novo Endpoint

1. Crie um controller em `Controllers/MyController.cbl`
2. Registre em `routes/api.cbl`
3. Configure middleware se necessário em `Middleware/`

---

## English - Directory Structure

### Main Components

- **Controllers/**: Contains all REST API controllers
- **Middleware/**: Contains programs that process HTTP requests
- **Kernel.cbl**: Central file that configures and starts the HTTP server

### Kernel.cbl File

The `Kernel.cbl` file is the heart of the HTTP system. It defines:

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. HTTPKERNEL.

      *> Comment: Central HTTP Kernel
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 SERVER-PORT PIC 9(4) VALUE 8080.
       01 SERVER-HOST PIC X(20) VALUE "localhost".
       01 IS-RUNNING PIC X VALUE 'Y'.
       01 REQUEST-BUFFER PIC X(1000).
       01 RESPONSE-BUFFER PIC X(1000).

       PROCEDURE DIVISION.

      *> Comment: Start HTTP server
           DISPLAY "Starting server on " & SERVER-HOST & ":" & SERVER-PORT

           PERFORM UNTIL IS-RUNNING = 'N'
               DISPLAY "Waiting for requests..."
               ACCEPT REQUEST-BUFFER
               CALL "PROCESS-REQUEST" USING REQUEST-BUFFER RESPONSE-BUFFER
               DISPLAY RESPONSE-BUFFER
           END-PERFORM

           GOBACK.
```

### Request Flow

```
1. Client makes HTTP request
   ↓
2. Kernel.cbl receives the request
   ↓
3. Middleware processes (authentication, validation, etc)
   ↓
4. Appropriate controller is called
   ↓
5. Response is returned to the client
```

### Example of Creating a New Endpoint

1. Create a controller in `Controllers/MyController.cbl`
2. Register in `routes/api.cbl`
3. Configure middleware if necessary in `Middleware/`

---

## Estrutura de Diretórios | Directory Structure

```
Http/
├── Controllers/
│   ├── WelcomeController.cbl
│   └── README.md
├── Middleware/
│   └── README.md
├── Kernel.cbl
└── README.md (this file)
```

Para mais informações, consulte os READMEs em cada subdiretório.

For more information, see the READMEs in each subdirectory.
