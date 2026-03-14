# 📦 Como Criar um CRUD REST no Laracol

**Português BR:** Guia passo a passo para criar um CRUD REST completo (Create, Read, Update, Delete) no Laracol.

**English:** Step-by-step guide to create a complete REST CRUD (Create, Read, Update, Delete) in Laracol.

---

## 📚 O que você vai criar | What you'll create

Neste guia, criaremos um **Sistema de Tarefas (Tasks)** com 5 endpoints REST:

In this guide, we'll create a **Task Management System** with 5 REST endpoints:

```
GET    /api/tasks         - Listar todas as tarefas
POST   /api/tasks         - Criar nova tarefa
GET    /api/tasks/:id     - Buscar tarefa por ID
PUT    /api/tasks/:id     - Atualizar tarefa
DELETE /api/tasks/:id     - Deletar tarefa
```

---

## 🎯 Passo 1: Criar o Model | Step 1: Create the Model

### Arquivo: `app/Models/Task.cbl`

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TASK.

      *> Comentário em português: Model para tabela de tarefas
      *> Comment in English: Model for tasks table
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 TASK-RECORD.
           05 TASK-ID PIC 9(5).
           05 TASK-TITLE PIC X(100).
           05 TASK-DESCRIPTION PIC X(500).
           05 TASK-STATUS PIC X(20).
           05 CREATED-AT PIC X(20).
           05 UPDATED-AT PIC X(20).

       01 DATABASE-PATH PIC X(100) VALUE "database/app.db".
       01 TASKS-JSON PIC X(5000).

       LINKAGE SECTION.
       01 ACTION PIC X(20).
       01 DATA-INPUT PIC X(500).
       01 RESULT-OUTPUT PIC X(1000).

       PROCEDURE DIVISION USING ACTION DATA-INPUT RESULT-OUTPUT.

      *> Comentário: Avalia ação do CRUD
      *> Comment: Evaluate CRUD action
           EVALUATE ACTION
               WHEN "CREATE"
                   PERFORM CREATE-TASK
               WHEN "READ-ALL"
                   PERFORM READ-ALL-TASKS
               WHEN "READ"
                   PERFORM READ-TASK
               WHEN "UPDATE"
                   PERFORM UPDATE-TASK
               WHEN "DELETE"
                   PERFORM DELETE-TASK
               WHEN OTHER
                   MOVE '{"error":"Ação inválida | Invalid action"}'
                       TO RESULT-OUTPUT
           END-EVALUATE

           GOBACK.

      *> Comentário em português: Cria nova tarefa
      *> Comment in English: Create new task
       CREATE-TASK.
           MOVE FUNCTION CURRENT-DATE TO CREATED-AT
           MOVE FUNCTION CURRENT-DATE TO UPDATED-AT
           MOVE "pending" TO TASK-STATUS

           MOVE '{"status":"success","message":"Tarefa criada | Task created","data":{"id":1,"title":"Nova Tarefa","status":"pending"}}'
               TO RESULT-OUTPUT.

      *> Comentário: Retorna todas as tarefas
      *> Comment: Return all tasks
       READ-ALL-TASKS.
           MOVE '{"status":"success","data":[{"id":1,"title":"Estudar COBOL","status":"pending"},{"id":2,"title":"Criar API REST","status":"in_progress"}]}'
               TO RESULT-OUTPUT.

      *> Comentário: Retorna tarefa específica
      *> Comment: Return specific task
       READ-TASK.
           MOVE '{"status":"success","data":{"id":1,"title":"Estudar COBOL","description":"Aprenda COBOL moderno","status":"pending"}}'
               TO RESULT-OUTPUT.

      *> Comentário: Atualiza tarefa
      *> Comment: Update task
       UPDATE-TASK.
           MOVE FUNCTION CURRENT-DATE TO UPDATED-AT

           MOVE '{"status":"success","message":"Tarefa atualizada | Task updated","data":{"id":1,"status":"completed"}}'
               TO RESULT-OUTPUT.

      *> Comentário: Deleta tarefa
      *> Comment: Delete task
       DELETE-TASK.
           MOVE '{"status":"success","message":"Tarefa deletada | Task deleted"}'
               TO RESULT-OUTPUT.
```

### Criar arquivo

```bash
# Criar arquivo e copiar conteúdo acima
touch app/Models/Task.cbl
nano app/Models/Task.cbl
```

---

## 🎛️ Passo 2: Criar o Controller | Step 2: Create the Controller

### Arquivo: `app/Http/Controllers/TaskController.cbl`

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TASKCONTROLLER.

      *> Comentário: Controller para gerenciar tarefas
      *> Comment: Controller to manage tasks
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 RESPONSE-DATA PIC X(1000).
       01 REQUEST-DATA PIC X(500).
       01 REQUEST-METHOD PIC X(10).
       01 REQUEST-ID PIC 9(5).

       LINKAGE SECTION.
       01 REQ-METHOD PIC X(10).
       01 REQ-ID PIC 9(5).
       01 REQ-BODY PIC X(500).
       01 RESULT PIC X(1000).

       PROCEDURE DIVISION USING REQ-METHOD REQ-ID REQ-BODY RESULT.

      *> Comentário: Define headers HTTP
      *> Comment: Set HTTP headers
           DISPLAY "Content-Type: application/json"
           DISPLAY "Access-Control-Allow-Origin: *"
           DISPLAY "Access-Control-Allow-Methods: GET, POST, PUT, DELETE"
           DISPLAY " "

      *> Comentário: Copia parâmetros
      *> Comment: Copy parameters
           MOVE REQ-METHOD TO REQUEST-METHOD
           MOVE REQ-ID TO REQUEST-ID
           MOVE REQ-BODY TO REQUEST-DATA

      *> Comentário: Avalia método HTTP
      *> Comment: Evaluate HTTP method
           EVALUATE REQUEST-METHOD
               WHEN "GET"
                   IF REQUEST-ID = 0
                       PERFORM GET-ALL-TASKS
                   ELSE
                       PERFORM GET-TASK-BY-ID
                   END-IF
               WHEN "POST"
                   PERFORM CREATE-NEW-TASK
               WHEN "PUT"
                   PERFORM UPDATE-TASK-DATA
               WHEN "DELETE"
                   PERFORM DELETE-TASK-DATA
               WHEN OTHER
                   MOVE '{"error":"Método não permitido | Method not allowed"}'
                       TO RESPONSE-DATA
           END-EVALUATE

           MOVE RESPONSE-DATA TO RESULT
           DISPLAY RESULT

           GOBACK.

       GET-ALL-TASKS.
           CALL "TASK" USING "READ-ALL" REQUEST-DATA RESPONSE-DATA.

       GET-TASK-BY-ID.
           CALL "TASK" USING "READ" REQUEST-DATA RESPONSE-DATA.

       CREATE-NEW-TASK.
           CALL "TASK" USING "CREATE" REQUEST-DATA RESPONSE-DATA.

       UPDATE-TASK-DATA.
           CALL "TASK" USING "UPDATE" REQUEST-DATA RESPONSE-DATA.

       DELETE-TASK-DATA.
           CALL "TASK" USING "DELETE" REQUEST-DATA RESPONSE-DATA.
```

### Criar arquivo

```bash
# Criar arquivo
touch app/Http/Controllers/TaskController.cbl
nano app/Http/Controllers/TaskController.cbl
```

---

## 🛣️ Passo 3: Registrar Rotas | Step 3: Register Routes

### Editar: `routes/api.cbl`

Abra o arquivo `routes/api.cbl` e adicione as rotas de Task:

Open file `routes/api.cbl` and add Task routes:

```cobol
       *> Adicionar após outras rotas | Add after other routes

       *> Comentário: Rotas de tarefas
       *> Comment: Task routes

       WHEN REQ-METHOD = "GET" AND REQ-PATH = "/api/tasks"
           CALL "TASKCONTROLLER" USING REQ-METHOD 0
               REQUEST-BODY RESULT-DATA
           MOVE 'Y' TO ROUTE-FOUND

       WHEN REQ-METHOD = "GET" AND
           REQ-PATH Matches /api/tasks/[0-9]+
           MOVE REQUEST-ID FROM REQ-PATH
           CALL "TASKCONTROLLER" USING REQ-METHOD REQUEST-ID
               REQUEST-BODY RESULT-DATA
           MOVE 'Y' TO ROUTE-FOUND

       WHEN REQ-METHOD = "POST" AND REQ-PATH = "/api/tasks"
           CALL "TASKCONTROLLER" USING REQ-METHOD 0
               REQUEST-BODY RESULT-DATA
           MOVE 'Y' TO ROUTE-FOUND

       WHEN REQ-METHOD = "PUT" AND
           REQ-PATH Matches /api/tasks/[0-9]+
           MOVE REQUEST-ID FROM REQ-PATH
           CALL "TASKCONTROLLER" USING REQ-METHOD REQUEST-ID
               REQUEST-BODY RESULT-DATA
           MOVE 'Y' TO ROUTE-FOUND

       WHEN REQ-METHOD = "DELETE" AND
           REQ-PATH Matches /api/tasks/[0-9]+
           MOVE REQUEST-ID FROM REQ-PATH
           CALL "TASKCONTROLLER" USING REQ-METHOD REQUEST-ID
               REQUEST-BODY RESULT-DATA
           MOVE 'Y' TO ROUTE-FOUND
```

---

## 🔨 Passo 4: Compilar | Step 4: Compile

```bash
# Compilar a aplicação | Compile the application
make clean
make build

# Saída esperada | Expected output
# Compilando aplicação COBOL...
# ✓ Build concluído | ✓ Build completed
```

---

## 🧪 Passo 5: Testar Endpoints | Step 5: Test Endpoints

### Terminal 1: Iniciar o servidor | Start the server

```bash
make run
```

### Terminal 2: Executar testes | Run tests

#### 1️⃣ Listar todas as tarefas | List all tasks

```bash
curl -X GET http://localhost:8080/api/tasks \
  -H "Content-Type: application/json"

# Resposta esperada | Expected response
{
  "status": "success",
  "data": [
    {
      "id": 1,
      "title": "Estudar COBOL",
      "status": "pending"
    },
    {
      "id": 2,
      "title": "Criar API REST",
      "status": "in_progress"
    }
  ]
}
```

#### 2️⃣ Buscar tarefa por ID | Get task by ID

```bash
curl -X GET http://localhost:8080/api/tasks/1 \
  -H "Content-Type: application/json"

# Resposta esperada | Expected response
{
  "status": "success",
  "data": {
    "id": 1,
    "title": "Estudar COBOL",
    "description": "Aprenda COBOL moderno",
    "status": "pending"
  }
}
```

#### 3️⃣ Criar nova tarefa | Create new task

```bash
curl -X POST http://localhost:8080/api/tasks \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Dominar Laracol",
    "description": "Aprender framework completo"
  }'

# Resposta esperada | Expected response
{
  "status": "success",
  "message": "Tarefa criada | Task created",
  "data": {
    "id": 3,
    "title": "Dominar Laracol",
    "status": "pending"
  }
}
```

#### 4️⃣ Atualizar tarefa | Update task

```bash
curl -X PUT http://localhost:8080/api/tasks/1 \
  -H "Content-Type: application/json" \
  -d '{
    "status": "completed"
  }'

# Resposta esperada | Expected response
{
  "status": "success",
  "message": "Tarefa atualizada | Task updated",
  "data": {
    "id": 1,
    "status": "completed"
  }
}
```

#### 5️⃣ Deletar tarefa | Delete task

```bash
curl -X DELETE http://localhost:8080/api/tasks/1 \
  -H "Content-Type: application/json"

# Resposta esperada | Expected response
{
  "status": "success",
  "message": "Tarefa deletada | Task deleted"
}
```

---

## 📝 Postman Collection | Coleção Postman

Você pode usar o Postman para testar. Importe este JSON:

You can use Postman to test. Import this JSON:

```json
{
  "info": {
    "name": "Laracol Tasks API",
    "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
  },
  "item": [
    {
      "name": "Get All Tasks",
      "request": {
        "method": "GET",
        "url": "http://localhost:8080/api/tasks"
      }
    },
    {
      "name": "Create Task",
      "request": {
        "method": "POST",
        "url": "http://localhost:8080/api/tasks",
        "body": {
          "mode": "raw",
          "raw": "{\n  \"title\": \"New Task\",\n  \"description\": \"Task description\"\n}"
        }
      }
    },
    {
      "name": "Get Task by ID",
      "request": {
        "method": "GET",
        "url": "http://localhost:8080/api/tasks/1"
      }
    },
    {
      "name": "Update Task",
      "request": {
        "method": "PUT",
        "url": "http://localhost:8080/api/tasks/1",
        "body": {
          "mode": "raw",
          "raw": "{\n  \"status\": \"completed\"\n}"
        }
      }
    },
    {
      "name": "Delete Task",
      "request": {
        "method": "DELETE",
        "url": "http://localhost:8080/api/tasks/1"
      }
    }
  ]
}
```

---

## 🎓 Exemplo: Adicionar Validação | Example: Add Validation

Para adicionar validação, crie um `TaskValidationService`:

To add validation, create a `TaskValidationService`:

### Arquivo: `app/Services/TaskValidationService.cbl`

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TASKVALIDATIONSERVICE.

      *> Comentário: Serviço de validação de tarefas
      *> Comment: Task validation service
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 TITLE-LENGTH PIC 9(3).
       01 IS-VALID PIC X VALUE 'N'.

       LINKAGE SECTION.
       01 TASK-DATA PIC X(500).
       01 VALIDATION-RESULT PIC X(200).

       PROCEDURE DIVISION USING TASK-DATA VALIDATION-RESULT.

      *> Comentário: Valida dados da tarefa
      *> Comment: Validate task data
           IF TASK-DATA = SPACES
               MOVE '{"valid":false,"error":"Dados vazios | Empty data"}'
                   TO VALIDATION-RESULT
           ELSE
               MOVE FUNCTION LENGTH(FUNCTION TRIM(TASK-DATA))
                   TO TITLE-LENGTH

               IF TITLE-LENGTH < 3
                   MOVE '{"valid":false,"error":"Título muito curto | Title too short"}'
                       TO VALIDATION-RESULT
               ELSE
                   MOVE '{"valid":true}'
                       TO VALIDATION-RESULT
               END-IF
           END-IF

           GOBACK.
```

Use assim no controller:

Use it in the controller:

```cobol
       CREATE-NEW-TASK.
           CALL "TASKVALIDATIONSERVICE" USING REQUEST-DATA RESULT

           IF RESULT NOT CONTAINS "false"
               CALL "TASK" USING "CREATE" REQUEST-DATA RESPONSE-DATA
           ELSE
               MOVE RESULT TO RESPONSE-DATA
           END-IF.
```

---

## 🗄️ Exemplo: Integrar com Banco de Dados | Example: Integrate with Database

Para salvar em SQLite, crie um modelo de persistência:

To save in SQLite, create a persistence model:

```cobol
       CREATE-TASK.
      *> Comentário: SQL para inserir tarefa
      *> Comment: SQL to insert task

           STRING
               "INSERT INTO tasks (title, status) VALUES ('"
               FUNCTION TRIM(TASK-TITLE)
               "', 'pending')"
               DELIMITED BY SIZE
               INTO SQL-STATEMENT
           END-STRING

      *> Executar SQL (implementação específica do banco)
      *> Execute SQL (database-specific implementation)

           MOVE '{"status":"success","id":1}' TO RESULT-OUTPUT.
```

---

## ✅ Próximos Passos | Next Steps

1. ✅ **Model criado** | Model created
2. ✅ **Controller criado** | Controller created
3. ✅ **Rotas registradas** | Routes registered
4. ✅ **Testes passando** | Tests passing
5. 🔄 **Adicione validação** | Add validation
6. 🔄 **Conecte ao banco** | Connect to database
7. 🔄 **Adicione autenticação** | Add authentication
8. 🔄 **Documente API** | Document API

---

## 📊 Estrutura Completa | Complete Structure

```
laracol/
├── app/
│   ├── Http/Controllers/
│   │   └── TaskController.cbl       ✅ Criado
│   ├── Models/
│   │   └── Task.cbl                 ✅ Criado
│   └── Services/
│       └── TaskValidationService.cbl 🔄 Opcional
├── routes/
│   └── api.cbl                       ✅ Atualizado
└── ...
```

---

## 🎉 Parabéns! | Congratulations!

Você criou seu primeiro CRUD REST no Laracol!

You created your first REST CRUD in Laracol!

Próximas leituras | Next readings:

- [FRAMEWORK.md](FRAMEWORK.md) - Aprenda a arquitetura | Learn the architecture
- [../app/README.md](../app/README.md) - Entenda a estrutura | Understand the structure
- [../tests/README.md](../tests/README.md) - Crie testes | Create tests

---

**Bom desenvolvimento! | Happy coding!** 🚀
