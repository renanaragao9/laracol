# Controllers | Controladores

📋 **Português BR:** Este diretório contém todos os controladores da API REST do Laracol Framework. Cada controlador processa requisições HTTP específicas.

📋 **English:** This directory contains all the controllers for the Laracol Framework REST API. Each controller handles specific HTTP requests.

---

## Português BR - Guia de Uso

### O que é um Controller?

Um controller é um programa COBOL que processa requisições HTTP e retorna respostas em JSON. Cada controlador deve ter um `PROGRAM-ID` único.

### Exemplo de Criar um Controller

Para criar um novo controller chamado `UserController.cbl`:

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. USERCONTROLLER.

      *> Comentário em português: Seção de dados do programa
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 RESPONSE-DATA PIC X(500).
       01 USER-ID PIC 9(5).
       01 USER-NAME PIC X(100).

       LINKAGE SECTION.
       01 REQUEST-PARAM PIC X(100).
       01 RESPONSE-OUTPUT PIC X(500).

       PROCEDURE DIVISION USING REQUEST-PARAM RESPONSE-OUTPUT.

           DISPLAY "Content-Type: application/json"
           DISPLAY " "

      *> Comentário em português: Processa requisição de usuário
           MOVE REQUEST-PARAM TO USER-ID
           MOVE "João Silva" TO USER-NAME

           MOVE '{"id":' & FUNCTION TRIM(USER-ID) &
               ',"name":"' & FUNCTION TRIM(USER-NAME) & '"}'
               TO RESPONSE-OUTPUT

           DISPLAY RESPONSE-OUTPUT

           GOBACK.
```

### Convenções de Nomes

1. **Arquivo**: Use PascalCase + "Controller" (exemplo: `UserController.cbl`, `ProductController.cbl`)
2. **PROGRAM-ID**: Deve corresponder ao nome do arquivo em UPPERCASE (exemplo: `USERCONTROLLER`)
3. **Métodos**: Estruture com `WHEN` para diferentes ações (GET, POST, PUT, DELETE)
4. **Resposta**: Sempre envie `Content-Type: application/json`

### Registrar na Rota

Em `routes/api.cbl`:

```cobol
           WHEN REQ-METHOD = "GET" AND REQ-PATH = "/api/users"
               CALL "USERCONTROLLER" USING REQUEST-PARAM RESPONSE
```

---

## English - Usage Guide

### What is a Controller?

A controller is a COBOL program that handles HTTP requests and returns JSON responses. Each controller must have a unique `PROGRAM-ID`.

### Example of Creating a Controller

To create a new controller called `ProductController.cbl`:

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRODUCTCONTROLLER.

      *> Comment in English: Data section for the program
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 RESPONSE-DATA PIC X(500).
       01 PRODUCT-ID PIC 9(5).
       01 PRODUCT-NAME PIC X(100).
       01 PRODUCT-PRICE PIC 9(7)V99.

       LINKAGE SECTION.
       01 REQUEST-PARAM PIC X(100).
       01 RESPONSE-OUTPUT PIC X(500).

       PROCEDURE DIVISION USING REQUEST-PARAM RESPONSE-OUTPUT.

           DISPLAY "Content-Type: application/json"
           DISPLAY " "

      *> Comment in English: Process product request
           MOVE REQUEST-PARAM TO PRODUCT-ID
           MOVE "Laptop" TO PRODUCT-NAME
           MOVE 2499.99 TO PRODUCT-PRICE

           MOVE '{"id":' & FUNCTION TRIM(PRODUCT-ID) &
               ',"name":"' & FUNCTION TRIM(PRODUCT-NAME) &
               '","price":' & FUNCTION TRIM(PRODUCT-PRICE) & '}'
               TO RESPONSE-OUTPUT

           DISPLAY RESPONSE-OUTPUT

           GOBACK.
```

### Naming Conventions

1. **File**: Use PascalCase + "Controller" (example: `UserController.cbl`, `ProductController.cbl`)
2. **PROGRAM-ID**: Must match filename in UPPERCASE (example: `USERCONTROLLER`)
3. **Methods**: Structure with `WHEN` for different actions (GET, POST, PUT, DELETE)
4. **Response**: Always send `Content-Type: application/json`

### Register in Routes

In `routes/api.cbl`:

```cobol
           WHEN REQ-METHOD = "POST" AND REQ-PATH = "/api/products"
               CALL "PRODUCTCONTROLLER" USING REQUEST-PARAM RESPONSE
```

---

## Arquivos de Exemplo | Example Files

Consulte `WelcomeController.cbl` para ver um exemplo funcional.  
See `WelcomeController.cbl` for a working example.
