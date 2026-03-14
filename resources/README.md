# Resources | Recursos

📋 **Português BR:** Diretório contendo recursos da aplicação como views, templates e arquivos estáticos.

📋 **English:** Directory containing application resources such as views, templates, and static files.

---

## Português BR - Estrutura de Recursos

### O que são Views?

Views são templates ou arquivos de resposta que a aplicação retorna. Podem ser JSON, HTML, XML ou qualquer outro formato.

### Estrutura do Diretório

```
resources/
├── views/           - Templates e views
└── README.md        - Este arquivo
```

### Exemplo de View JSON

Arquivo `resources/views/users.json`:

```json
{
  "comentário em português": "Resposta padrão para listagem de usuários",
  "comment in english": "Standard response for listing users",
  "data": [
    {
      "id": 1,
      "name": "João Silva",
      "email": "joao@email.com",
      "created_at": "2024-03-13 10:30:00"
    },
    {
      "id": 2,
      "name": "Maria Santos",
      "email": "maria@email.com",
      "created_at": "2024-03-13 11:00:00"
    }
  ],
  "meta": {
    "total": 2,
    "per_page": 15,
    "current_page": 1
  }
}
```

### Como Usar Views em COBOL

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. USERCONTROLLER.

      *> Comentário: Controller que usa view
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 RESPONSE-DATA PIC X(5000).
       01 VIEW-FILE PIC X(100) VALUE
           "resources/views/users.json".

       PROCEDURE DIVISION.

      *> Comentário: Lê view e retorna ao cliente
           DISPLAY "Content-Type: application/json"
           DISPLAY " "

           MOVE '{"status":"success","data":[]}'
               TO RESPONSE-DATA

           DISPLAY RESPONSE-DATA

           GOBACK.
```

### Estrutura Recomendada

```
resources/
├── views/
│   ├── users.json
│   ├── products.json
│   ├── errors/
│   │   ├── 404.json
│   │   └── 500.json
│   └── README.md
└── README.md
```

### Padrão de Resposta

Todas as respostas JSON devem seguir este padrão:

```json
{
  "status": "success|error",
  "data": {},
  "message": "Mensagem descritiva",
  "timestamp": "2024-03-13T10:30:00Z"
}
```

---

## English - Resource Structure

### What are Views?

Views are templates or response files that the application returns. They can be JSON, HTML, XML, or any other format.

### Directory Structure

```
resources/
├── views/           - Templates and views
└── README.md        - This file
```

### Example of JSON View

File `resources/views/products.json`:

```json
{
  "comment in portuguese": "Standard response for listing products",
  "comment in english": "Standard response for listing products",
  "data": [
    {
      "id": 1,
      "name": "Laptop",
      "price": 2499.99,
      "stock": 5,
      "created_at": "2024-03-13 10:30:00"
    },
    {
      "id": 2,
      "name": "Mouse",
      "price": 49.99,
      "stock": 50,
      "created_at": "2024-03-13 11:00:00"
    }
  ],
  "meta": {
    "total": 2,
    "per_page": 15,
    "current_page": 1
  }
}
```

### How to Use Views in COBOL

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRODUCTCONTROLLER.

      *> Comment: Controller that uses view
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 RESPONSE-DATA PIC X(5000).
       01 VIEW-FILE PIC X(100) VALUE
           "resources/views/products.json".

       PROCEDURE DIVISION.

      *> Comment: Read view and return to client
           DISPLAY "Content-Type: application/json"
           DISPLAY " "

           MOVE '{"status":"success","data":[]}'
               TO RESPONSE-DATA

           DISPLAY RESPONSE-DATA

           GOBACK.
```

### Recommended Structure

```
resources/
├── views/
│   ├── users.json
│   ├── products.json
│   ├── orders.json
│   ├── errors/
│   │   ├── 404.json
│   │   ├── 500.json
│   │   └── 401.json
│   └── README.md
└── README.md
```

### Standard Response Pattern

All JSON responses should follow this pattern:

```json
{
  "status": "success|error",
  "data": {},
  "message": "Descriptive message",
  "timestamp": "2024-03-13T10:30:00Z"
}
```

---

## Tipos de Views | View Types

| Tipo | Descrição         | Uso                 |
| ---- | ----------------- | ------------------- |
| JSON | Formato JSON puro | APIs REST           |
| XML  | Formato XML       | Sistemas legados    |
| HTML | Páginas HTML      | Aplicações web      |
| CSV  | Formato CSV       | Exportação de dados |
| TEXT | Texto puro        | Logs ou relatórios  |

| Type | Description      | Usage            |
| ---- | ---------------- | ---------------- |
| JSON | Pure JSON format | REST APIs        |
| XML  | XML format       | Legacy systems   |
| HTML | HTML pages       | Web applications |
| CSV  | CSV format       | Data export      |
| TEXT | Plain text       | Logs or reports  |

---

## Exemplos de Error Views | Error View Examples

### 404 Not Found

```json
{
  "status": "error",
  "message": "Recurso não encontrado | Resource not found",
  "message_pt": "O recurso solicitado não foi encontrado",
  "message_en": "The requested resource was not found",
  "error_code": 404
}
```

### 500 Internal Server Error

```json
{
  "status": "error",
  "message": "Erro interno do servidor | Internal server error",
  "message_pt": "Algo deu errado no servidor",
  "message_en": "Something went wrong on the server",
  "error_code": 500
}
```
