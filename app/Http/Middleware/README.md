# Middleware | Middleware

📋 **Português BR:** Middlewares são programas COBOL que processam requisições HTTP antes de chegarem aos controllers. Eles são úteis para autenticação, validação e transformação de dados.

📋 **English:** Middleware are COBOL programs that process HTTP requests before they reach the controllers. They are useful for authentication, validation, and data transformation.

---

## Português BR - Guia de Uso

### O que é Middleware?

Middleware é um programa COBOL que intercepta e processa requisições HTTP antes de passá-las para o controller apropriado. É o lugar ideal para autenticação, autorização e validação.

### Exemplo de Criar Middleware

Para criar um novo middleware chamado `AuthMiddleware.cbl`:

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. AUTHMIDDLEWARE.

      *> Comentário em português: Verifica token de autenticação
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 AUTH-TOKEN PIC X(100).
       01 IS-VALID PIC X VALUE 'N'.
       01 RESPONSE-MSG PIC X(200).

       LINKAGE SECTION.
       01 REQUEST-TOKEN PIC X(100).
       01 VALIDATION-RESULT PIC X(50).

       PROCEDURE DIVISION USING REQUEST-TOKEN VALIDATION-RESULT.

      *> Comentário em português: Valida o token
           MOVE REQUEST-TOKEN TO AUTH-TOKEN

           IF AUTH-TOKEN = SPACES OR AUTH-TOKEN = ""
               MOVE 'N' TO IS-VALID
               MOVE '{"error":"Token não fornecido"}' TO VALIDATION-RESULT
           ELSE
               MOVE 'Y' TO IS-VALID
               MOVE '{"status":"authorized"}' TO VALIDATION-RESULT
           END-IF

           GOBACK.
```

### Tipos de Middleware

1. **Autenticação**: Valida credenciais do usuário
2. **Autorização**: Verifica permissões
3. **Validação**: Valida dados de entrada
4. **CORS**: Gerencia requisições cruzadas

### Estrutura Recomendada

```
Middleware/
├── AuthMiddleware.cbl
├── CorsMiddleware.cbl
├── ValidationMiddleware.cbl
└── README.md (este arquivo)
```

---

## English - Usage Guide

### What is Middleware?

Middleware is a COBOL program that intercepts and processes HTTP requests before passing them to the appropriate controller. It is the ideal place for authentication, authorization, and validation.

### Example of Creating Middleware

To create a new middleware called `LoggingMiddleware.cbl`:

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. LOGGINGMIDDLEWARE.

      *> Comment in English: Logs HTTP request information
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 REQUEST-METHOD PIC X(10).
       01 REQUEST-PATH PIC X(100).
       01 LOG-MESSAGE PIC X(300).
       01 TIMESTAMP PIC X(20).

       LINKAGE SECTION.
       01 REQ-METHOD PIC X(10).
       01 REQ-PATH PIC X(100).
       01 LOG-OUTPUT PIC X(300).

       PROCEDURE DIVISION USING REQ-METHOD REQ-PATH LOG-OUTPUT.

      *> Comment in English: Log request details
           MOVE REQ-METHOD TO REQUEST-METHOD
           MOVE REQ-PATH TO REQUEST-PATH
           MOVE FUNCTION CURRENT-DATE TO TIMESTAMP

           MOVE '[' & FUNCTION TRIM(TIMESTAMP) & '] ' &
               'Request: ' & FUNCTION TRIM(REQUEST-METHOD) & ' ' &
               FUNCTION TRIM(REQUEST-PATH)
               TO LOG-OUTPUT

           DISPLAY LOG-OUTPUT

           GOBACK.
```

### Types of Middleware

1. **Authentication**: Validates user credentials
2. **Authorization**: Checks user permissions
3. **Validation**: Validates input data
4. **CORS**: Manages cross-origin requests

### Recommended Structure

```
Middleware/
├── AuthMiddleware.cbl
├── CorsMiddleware.cbl
├── ValidationMiddleware.cbl
└── README.md (this file)
```

---

## Padrão de Uso | Usage Pattern

Middleware pode ser encadeado para processar requisições sequencialmente:

Middleware can be chained to process requests sequentially:

```cobol
CALL "AUTHMIDDLEWARE" USING TOKEN RESULT1
CALL "VALIDATIONMIDDLEWARE" USING REQUEST RESULT2
CALL "LOGGINGMIDDLEWARE" USING METHOD PATH RESULT3
```
