# Routes | Rotas

📋 **Português BR:** Diretório contendo definição de rotas da API REST. O arquivo `api.cbl` mapeia URLs para controllers.

📋 **English:** Directory containing REST API route definitions. The `api.cbl` file maps URLs to controllers.

---

## Português BR - Sistema de Rotas

### O que é um Sistema de Rotas?

Um sistema de rotas mapeia requisições HTTP (GET, POST, PUT, DELETE) a métodos específicos de controllers. É o "direcionador de tráfego" da API.

### Exemplo de api.cbl

Arquivo `routes/api.cbl` com definição de rotas:

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. APIROUTER.

      *> Comentário: Router principal da API
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 REQUEST-METHOD PIC X(10).
       01 REQUEST-PATH PIC X(200).
       01 ROUTE-FOUND PIC X VALUE 'N'.
       01 RESPONSE PIC X(1000).

       LINKAGE SECTION.
       01 REQ-METHOD PIC X(10).
       01 REQ-PATH PIC X(200).
       01 REQ-BODY PIC X(5000).
       01 RESULT-DATA PIC X(5000).

       PROCEDURE DIVISION USING REQ-METHOD REQ-PATH REQ-BODY RESULT-DATA.

      *> Comentário: Copia parâmetros de entrada
           MOVE REQ-METHOD TO REQUEST-METHOD
           MOVE REQ-PATH TO REQUEST-PATH

      *> Comentário: Avalia rotas GET
           IF REQUEST-METHOD = "GET"
               EVALUATE REQUEST-PATH
                   WHEN "/api/users"
                       CALL "USERCONTROLLER" USING RESULT-DATA
                       MOVE 'Y' TO ROUTE-FOUND
                   WHEN "/api/products"
                       CALL "PRODUCTCONTROLLER" USING RESULT-DATA
                       MOVE 'Y' TO ROUTE-FOUND
                   WHEN "/api/welcome"
                       CALL "WELCOMECONTROLLER" USING RESULT-DATA
                       MOVE 'Y' TO ROUTE-FOUND
               END-EVALUATE
           END-IF

      *> Comentário: Avalia rotas POST
           IF REQUEST-METHOD = "POST"
               EVALUATE REQUEST-PATH
                   WHEN "/api/users"
                       CALL "USERCONTROLLER" USING REQ-BODY RESULT-DATA
                       MOVE 'Y' TO ROUTE-FOUND
                   WHEN "/api/products"
                       CALL "PRODUCTCONTROLLER" USING REQ-BODY RESULT-DATA
                       MOVE 'Y' TO ROUTE-FOUND
               END-EVALUATE
           END-IF

      *> Comentário: Avalia rotas PUT
           IF REQUEST-METHOD = "PUT"
               EVALUATE REQUEST-PATH
                   WHEN "/api/users"
                       CALL "USERCONTROLLER" USING REQ-BODY RESULT-DATA
                       MOVE 'Y' TO ROUTE-FOUND
               END-EVALUATE
           END-IF

      *> Comentário: Avalia rotas DELETE
           IF REQUEST-METHOD = "DELETE"
               EVALUATE REQUEST-PATH
                   WHEN "/api/users"
                       CALL "USERCONTROLLER" USING REQ-BODY RESULT-DATA
                       MOVE 'Y' TO ROUTE-FOUND
               END-EVALUATE
           END-IF

      *> Comentário: Retorna 404 se rota não encontrada
           IF ROUTE-FOUND = 'N'
               MOVE '{"error":"Rota não encontrada","path":"' &
                   FUNCTION TRIM(REQUEST-PATH) & '"}'
                   TO RESULT-DATA
           END-IF

           GOBACK.
```

### Mapping de Rotas

| Método | Rota           | Controller        | Ação              |
| ------ | -------------- | ----------------- | ----------------- |
| GET    | /api/users     | UserController    | Listar usuários   |
| POST   | /api/users     | UserController    | Criar usuário     |
| GET    | /api/users/:id | UserController    | Buscar usuário    |
| PUT    | /api/users/:id | UserController    | Atualizar usuário |
| DELETE | /api/users/:id | UserController    | Deletar usuário   |
| GET    | /api/products  | ProductController | Listar produtos   |
| POST   | /api/products  | ProductController | Criar produto     |

### Padrão RESTful

```
GET    /api/resource       - Listar todos
POST   /api/resource       - Criar novo
GET    /api/resource/:id   - Buscar por ID
PUT    /api/resource/:id   - Atualizar
DELETE /api/resource/:id   - Deletar
PATCH  /api/resource/:id   - Atualização parcial
```

---

## English - Route System

### What is a Route System?

A route system maps HTTP requests (GET, POST, PUT, DELETE) to specific controller methods. It is the "traffic director" of the API.

### Example of api.cbl

File `routes/api.cbl` with route definition:

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. APIROUTER.

      *> Comment: Main API router
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 REQUEST-METHOD PIC X(10).
       01 REQUEST-PATH PIC X(200).
       01 ROUTE-FOUND PIC X VALUE 'N'.
       01 RESPONSE PIC X(1000).

       LINKAGE SECTION.
       01 REQ-METHOD PIC X(10).
       01 REQ-PATH PIC X(200).
       01 REQ-BODY PIC X(5000).
       01 RESULT-DATA PIC X(5000).

       PROCEDURE DIVISION USING REQ-METHOD REQ-PATH REQ-BODY RESULT-DATA.

      *> Comment: Copy input parameters
           MOVE REQ-METHOD TO REQUEST-METHOD
           MOVE REQ-PATH TO REQUEST-PATH

      *> Comment: Evaluate GET routes
           IF REQUEST-METHOD = "GET"
               EVALUATE REQUEST-PATH
                   WHEN "/api/users"
                       CALL "USERCONTROLLER" USING RESULT-DATA
                       MOVE 'Y' TO ROUTE-FOUND
                   WHEN "/api/products"
                       CALL "PRODUCTCONTROLLER" USING RESULT-DATA
                       MOVE 'Y' TO ROUTE-FOUND
                   WHEN "/api/welcome"
                       CALL "WELCOMECONTROLLER" USING RESULT-DATA
                       MOVE 'Y' TO ROUTE-FOUND
               END-EVALUATE
           END-IF

      *> Comment: Evaluate POST routes
           IF REQUEST-METHOD = "POST"
               EVALUATE REQUEST-PATH
                   WHEN "/api/users"
                       CALL "USERCONTROLLER" USING REQ-BODY RESULT-DATA
                       MOVE 'Y' TO ROUTE-FOUND
                   WHEN "/api/products"
                       CALL "PRODUCTCONTROLLER" USING REQ-BODY RESULT-DATA
                       MOVE 'Y' TO ROUTE-FOUND
               END-EVALUATE
           END-IF

      *> Comment: Evaluate PUT routes
           IF REQUEST-METHOD = "PUT"
               EVALUATE REQUEST-PATH
                   WHEN "/api/users"
                       CALL "USERCONTROLLER" USING REQ-BODY RESULT-DATA
                       MOVE 'Y' TO ROUTE-FOUND
               END-EVALUATE
           END-IF

      *> Comment: Evaluate DELETE routes
           IF REQUEST-METHOD = "DELETE"
               EVALUATE REQUEST-PATH
                   WHEN "/api/users"
                       CALL "USERCONTROLLER" USING REQ-BODY RESULT-DATA
                       MOVE 'Y' TO ROUTE-FOUND
               END-EVALUATE
           END-IF

      *> Comment: Return 404 if route not found
           IF ROUTE-FOUND = 'N'
               MOVE '{"error":"Route not found","path":"' &
                   FUNCTION TRIM(REQUEST-PATH) & '"}'
                   TO RESULT-DATA
           END-IF

           GOBACK.
```

### Route Mapping

| Method | Route          | Controller        | Action         |
| ------ | -------------- | ----------------- | -------------- |
| GET    | /api/users     | UserController    | List users     |
| POST   | /api/users     | UserController    | Create user    |
| GET    | /api/users/:id | UserController    | Get user       |
| PUT    | /api/users/:id | UserController    | Update user    |
| DELETE | /api/users/:id | UserController    | Delete user    |
| GET    | /api/products  | ProductController | List products  |
| POST   | /api/products  | ProductController | Create product |

### RESTful Pattern

```
GET    /api/resource       - List all
POST   /api/resource       - Create new
GET    /api/resource/:id   - Get by ID
PUT    /api/resource/:id   - Update
DELETE /api/resource/:id   - Delete
PATCH  /api/resource/:id   - Partial update
```

---

## Estrutura Recomendada | Recommended Structure

```
routes/
├── api.cbl          - Definição de rotas
├── web.cbl          - Rotas web (opcional)
└── README.md        - Este arquivo
```

## Exemplo com Prefixo de Versão | Example with Version Prefix

```cobol
       WHEN "/api/v1/users"
           CALL "USERCONTROLLER-V1" USING RESULT-DATA
       WHEN "/api/v2/users"
           CALL "USERCONTROLLER-V2" USING RESULT-DATA
```

## Prioridade de Rotas | Route Priority

As rotas são avaliadas em ordem:

1. Rotas mais específicas (com operações)
2. Rotas gerais (resource)
3. 404 - Rota não encontrada

Routes are evaluated in order:

1. More specific routes (with operations)
2. General routes (resource)
3. 404 - Route not found
