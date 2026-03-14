# 🏗️ Entendendo o Framework Laracol

**Português BR:** Guia detalhado sobre a arquitetura, padrões de design e filosofia do Laracol Framework.

**English:** Detailed guide on the architecture, design patterns, and philosophy of the Laracol Framework.

---

## 🎯 Filosofia do Laracol | Laracol Philosophy

### Português BR

O Laracol é uma adaptação do **Laravel** para COBOL, baseado em três princípios:

1. **Simplicidade** - Código limpo e organizado
2. **Produtividade** - Menos código, mais features
3. **Modernidade** - Padrões de frameworks modernos em COBOL

### English

Laracol is an adaptation of **Laravel** for COBOL, based on three principles:

1. **Simplicity** - Clean and organized code
2. **Productivity** - Less code, more features
3. **Modernity** - Modern framework patterns in COBOL

---

## 🏛️ Padrão MVC Adaptado | Adapted MVC Pattern

### Português BR

Laracol segue o padrão MVC (Model-View-Controller), adaptado para COBOL CGI:

```
┌─────────────────────────────────────────────────────┐
│                   HTTP Request                      │
└────────────────────┬────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────────┐
│   CGI (public/index.cgi)                            │
│   - Recebe requisição HTTP                          │
│   - Extrai método, path, body                       │
└────────────────────┬────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────────┐
│   HTTP Kernel (app/Http/Kernel.cbl)                 │
│   - Inicializa servidor                             │
│   - Processa requisições                            │
└────────────────────┬────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────────┐
│   Middleware (app/Http/Middleware/)                 │
│   - Autenticação/Autorização                        │
│   - Validação                                       │
│   - CORS                                            │
└────────────────────┬────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────────┐
│   Router (routes/api.cbl)                           │
│   - Mapeia URL para Controller                      │
│   - Define rotas REST                               │
└────────────────────┬────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────────┐
│   CONTROLLER (app/Http/Controllers/)                │
│   - Processa requisição                             │
│   - Chama Model/Service                             │
│   - Retorna resposta                                │
└────────────────────┬────────────────────────────────┘
              ┌──────┴──────┬──────────────┐
              ↓             ↓              ↓
         ┌────────┐  ┌──────────┐  ┌──────────────┐
         │ MODEL  │  │ SERVICE  │  │   PROVIDER   │
         │        │  │          │  │              │
         │ CRUD   │  │ Lógica   │  │ Inicializ.   │
         │ BD     │  │ Negócio  │  │ Serviços     │
         └────────┘  └──────────┘  └──────────────┘
```

### English

Laracol follows the MVC (Model-View-Controller) pattern, adapted for COBOL CGI:

Similar diagram as above, but all labels in English.

---

## 🔌 Componentes Principais | Main Components

### 1. Model (app/Models/)

**Tipo**: Camada de dados  
**Responsabilidade**: CRUD (Create, Read, Update, Delete)  
**Padrão**: Ativo (Active Record)

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. USER.

      *> Model é o espelho da tabela no banco
      *> Model mirrors the database table
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 USER-FIELDS.
           05 USER-ID PIC 9(5).
           05 USER-NAME PIC X(100).
           05 USER-EMAIL PIC X(100).

       LINKAGE SECTION.
       01 ACTION PIC X(20).
       01 INPUT-DATA PIC X(500).
       01 OUTPUT-DATA PIC X(500).

       PROCEDURE DIVISION USING ACTION INPUT-DATA OUTPUT-DATA.

      *> Método CRUD
           EVALUATE ACTION
               WHEN "CREATE" PERFORM CREATE-USER
               WHEN "READ" PERFORM READ-USER
               WHEN "UPDATE" PERFORM UPDATE-USER
               WHEN "DELETE" PERFORM DELETE-USER
           END-EVALUATE

           GOBACK.
```

**Características**:

- Encapsula lógica de acesso a dados
- Define estrutura da entidade
- Implementa validações de campo
- Gerencia relacionamentos

### 2. Controller (app/Http/Controllers/)

**Tipo**: Camada de aplicação  
**Responsabilidade**: Processar requisições HTTP  
**Padrão**: Action-based

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. USERCONTROLLER.

      *> Controller recebe requisição HTTP
      *> e retorna resposta JSON
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 RESPONSE-DATA PIC X(1000).

       LINKAGE SECTION.
       01 REQUEST-METHOD PIC X(10).
       01 REQUEST-BODY PIC X(500).
       01 RESULT PIC X(1000).

       PROCEDURE DIVISION USING REQUEST-METHOD REQUEST-BODY RESULT.

      *> Mapeia métodos HTTP para ações
           EVALUATE REQUEST-METHOD
               WHEN "POST" PERFORM CREATE-ACTION
               WHEN "GET" PERFORM READ-ACTION
               WHEN "PUT" PERFORM UPDATE-ACTION
               WHEN "DELETE" PERFORM DELETE-ACTION
           END-EVALUATE

           MOVE RESPONSE-DATA TO RESULT
           GOBACK.
```

**Características**:

- Recebe requisição HTTP (method, body, params)
- Valida entrada (delega a Service)
- Chama Model ou Service para processar
- Retorna resposta em JSON

### 3. Service (app/Services/)

**Tipo**: Camada de negócio  
**Responsabilidade**: Lógica complexa reutilizável  
**Padrão**: Utilidade

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. USERREGISTRATIONSERVICE.

      *> Service contém lógica de negócio complexa
      *> que pode ser reutilizada por múltiplos controllers
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 USER-EMAIL PIC X(100).
       01 REGISTRATION-RESULT PIC X(500).

       LINKAGE SECTION.
       01 EMAIL PIC X(100).
       01 PASSWORD PIC X(100).
       01 RESULT PIC X(500).

       PROCEDURE DIVISION USING EMAIL PASSWORD RESULT.

      *> Valida email | Validate email
           IF EMAIL NOT CONTAINS "@"
               MOVE '{"error":"Email inválido"}' TO RESULT
           ELSE
               PERFORM REGISTER-USER
               MOVE REGISTRATION-RESULT TO RESULT
           END-IF

           GOBACK.

       REGISTER-USER.
      *> Criptografa senha | Hash password
      *> Cria usuário | Create user
      *> Envia email | Send email
      *> Registra em log | Log registration
           MOVE '{"status":"registered"}' TO REGISTRATION-RESULT.
```

**Características**:

- Lógica de negócio complexa
- Reutilizável por múltiplos controllers
- Independente de entrada/saída
- Fácil de testar

### 4. Middleware (app/Http/Middleware/)

**Tipo**: Camada de processamento  
**Responsabilidade**: Interceptar requisições  
**Padrão**: Filtro

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. AUTHMIDDLEWARE.

      *> Middleware valida antes de chegar ao controller
      *> Middleware validates before reaching controller
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 TOKEN PIC X(200).
       01 IS-VALID PIC X VALUE 'N'.

       LINKAGE SECTION.
       01 AUTH-HEADER PIC X(200).
       01 VALIDATION-RESULT PIC X(100).

       PROCEDURE DIVISION USING AUTH-HEADER VALIDATION-RESULT.

      *> Valida token | Validate token
           IF AUTH-HEADER NOT CONTAINS "Bearer"
               MOVE "INVALID" TO VALIDATION-RESULT
           ELSE
               MOVE "VALID" TO VALIDATION-RESULT
           END-IF

           GOBACK.
```

**Características**:

- Executa antes do controller
- Pode rejeitar requisição
- Transforma dados da requisição
- Logging de eventos

### 5. Provider (app/Providers/)

**Tipo**: Camada de bootstrap  
**Responsabilidade**: Inicializar serviços  
**Padrão**: Factory

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. DATABASEPROVIDER.

      *> Provider inicializa serviços
      *> Provider initializes services
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 DB-STATUS PIC X(50).

       LINKAGE SECTION.
       01 INIT-RESULT PIC X(100).

       PROCEDURE DIVISION USING INIT-RESULT.

      *> Conecta ao banco | Connect to database
      *> Configura pool | Configure pool
      *> Executa migrations | Run migrations
           MOVE "Database initialized" TO INIT-RESULT

           GOBACK.
```

**Características**:

- Configura dependências
- Registra bindings
- Executa bootstrap
- Gerencia inicialização

---

## 🔄 Fluxo de uma Requisição | Request Flow

### Exemplo: POST /api/users

```cobol
1. Cliente faz requisição
   POST /api/users HTTP/1.1
   Content-Type: application/json

   {"name": "João", "email": "joao@email.com"}

2. CGI recebe e extrai dados
   REQUEST-METHOD = "POST"
   REQUEST-PATH = "/api/users"
   REQUEST-BODY = {"name": "João", ...}

3. Kernel HTTP inicia
   - Define headers
   - Inicializa variáveis

4. Middleware executa
   - Valida Content-Type
   - Verifica autenticação
   - Logs da requisição

5. Router mapeia requisição
   WHEN REQ-METHOD = "POST" AND REQ-PATH = "/api/users"
       CALL "USERCONTROLLER"

6. Controller processa
   - Valida dados (pode chamar Service)
   - Chama Model.CREATE
   - Prepara resposta JSON

7. Response é retornada
   {
     "status": "success",
     "data": {"id": 1, "name": "João"}
   }

8. Cliente recebe resposta
```

---

## 📐 Padrões de Design | Design Patterns

### 1. Active Record (Models)

**Descrição**: Modelo com métodos CRUD integrados

```cobol
CALL "USER" USING "CREATE" INPUT OUTPUT
CALL "USER" USING "READ" INPUT OUTPUT
CALL "USER" USING "UPDATE" INPUT OUTPUT
CALL "USER" USING "DELETE" INPUT OUTPUT
```

### 2. Model-View-Controller (MVC)

**Descrição**: Separação de responsabilidades

- **Model**: Dados
- **View**: Resposta (JSON)
- **Controller**: Lógica de requisição

### 3. Dependency Injection (Providers)

**Descrição**: Injetar dependências na inicialização

```cobol
CALL "DATABASEPROVIDER" USING DB-STATUS
CALL "CACHEPROVIDER" USING CACHE-STATUS
CALL "AUTHPROVIDER" USING AUTH-STATUS
```

### 4. Strategy (Services)

**Descrição**: Diferentes implementações da mesma interface

```cobol
CALL "EMAILSERVICE" USING EMAIL DATA RESULT
CALL "SMTPSERVICE" USING EMAIL DATA RESULT  *> Alternativa
```

### 5. Filter/Middleware

**Descrição**: Processar requisição antes/depois

```cobol
CALL "AUTHMIDDLEWARE" -> Valida -> CALL "CONTROLLER"
CALL "LOGMIDDLEWARE" -> Log entrada e saída
```

---

## 🗂️ Organização de Código | Code Organization

### Por Responsabilidade | By Responsibility

```
app/
├── Http/
│   ├── Controllers/    - Lógica de requisição
│   ├── Middleware/     - Filtros de requisição
│   └── Kernel.cbl      - Inicializador HTTP
├── Models/             - Lógica de dados
├── Services/           - Lógica de negócio
└── Providers/          - Inicializadores

routes/
└── api.cbl             - Mapeamento de rotas

config/
├── app.conf            - Configuração geral
└── database.conf       - Configuração BD
```

### Por Feature | By Feature (Alternativa)

```
features/
├── users/
│   ├── UserModel.cbl
│   ├── UserController.cbl
│   ├── UserService.cbl
│   └── user_routes.cbl
├── products/
│   ├── ProductModel.cbl
│   ├── ProductController.cbl
│   └── product_routes.cbl
```

---

## 🔐 Ciclo de Vida da Aplicação | Application Lifecycle

### 1. Bootstrap | Inicialização

```cobol
app/cbl inicia

CALL "APPBOOTSTRAP"
  ├── CALL "DATABASEPROVIDER"
  ├── CALL "CACHEPROVIDER"
  ├── CALL "AUTHPROVIDER"
  └── CALL "LOGGINGPROVIDER"

CALL "HTTPKERNEL"
  └── Start listening on port 8080
```

### 2. Request | Requisição

```cobol
Cliente -> CGI -> Kernel -> Middleware -> Router -> Controller
                                              ↓
                                          Model/Service
                                              ↓
                                            Response
```

### 3. Response | Resposta

```cobol
Controller cria resposta JSON
Middleware pode adicionar headers
Kernel finaliza
CGI retorna ao cliente
```

### 4. Shutdown | Encerramento

```cobol
make stop
  └── Kill processo
      Fechar conexões BD
      Logs finais
```

---

## 📊 Arquitetura de Camadas | Layered Architecture

```
┌──────────────────────────────┐
│      Presentation Layer      │  HTTP, JSON, REST
│      (Controllers)           │
└──────────────────┬───────────┘
                   │
┌──────────────────┴───────────┐
│    Application Layer         │  Lógica de requisição
│    (Middleware, Router)      │  Validação, Segurança
└──────────────────┬───────────┘
                   │
┌──────────────────┴───────────┐
│      Business Logic Layer    │  Serviços, Regras negócio
│      (Services)              │  Cálculos, Processamento
└──────────────────┬───────────┘
                   │
┌──────────────────┴───────────┐
│      Data Access Layer       │  Models, CRUD
│      (Models)                │  Queries, Transactions
└──────────────────┬───────────┘
                   │
┌──────────────────┴───────────┐
│      Persistence Layer       │  SQLite, PostgreSQL
│      (Database)              │  Cache, Arquivos
└──────────────────────────────┘
```

---

## 💡 Boas Práticas | Best Practices

### 1. Controllers Magros | Thin Controllers

```cobol
❌ Evitar - Lógica no controller
PROCEDURE DIVISION.
    IF EMAIL NOT CONTAINS "@"
        String complexa de validação
        Criptografia de senha
        Lógica de negócio
    END-IF.

✅ Fazer - Dele gar para Service
PROCEDURE DIVISION.
    CALL "USERREGISTRATIONSERVICE" USING EMAIL PASSWORD RESULT.
```

### 2. Models Gordos | Fat Models

```cobol
✅ Fazer - Lógica no Model
01 MODEL-METHODS.
    - Validação de campo
    - Relacionamentos
    - Scopes de query
    - Métodos auxiliares
```

### 3. Services Reutilizáveis | Reusable Services

```cobol
✅ Fazer - Service genérico
CALL "EMAILSERVICE" USING EMAIL SUBJECT BODY RESULT

✅ Usar em múltiplos controllers
CALL "USERCONTROLLER" ... -> CALL "EMAILSERVICE"
CALL "ORDERCONTROLLER" ... -> CALL "EMAILSERVICE"
```

### 4. DRY (Don't Repeat Yourself)

```cobol
❌ Evitar - Repetição
USERCONTROLLER: calcular imposto
ORDERCONTROLLER: calcular imposto
INVOICECONTROLLER: calcular imposto

✅ Fazer - Centralizar
CALL "TAXSERVICE" USING AMOUNT RESULT
```

---

## 🧪 Testabilidade | Testability

### Estrutura de Testes

```
tests/
├── Unit/
│   ├── UserModelTest.cbl
│   ├── EmailServiceTest.cbl
│   └── ValidationTest.cbl
├── Integration/
│   ├── APITest.cbl
│   └── DatabaseTest.cbl
└── Feature/
    ├── UserRegistrationTest.cbl
    └── OrderFlowTest.cbl
```

### Exemplo de Teste

```cobol
IDENTIFICATION DIVISION.
PROGRAM-ID. USERCRUDTEST.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 TEST-COUNT PIC 9(3) VALUE 0.
01 PASSED PIC 9(3) VALUE 0.

PROCEDURE DIVISION.

    *> Teste 1: Criar usuário
    ADD 1 TO TEST-COUNT
    CALL "USER" USING "CREATE" INPUT RESULT

    IF RESULT CONTAINS "success"
        ADD 1 TO PASSED
    END-IF

    *> Teste 2: Buscar usuário
    ADD 1 TO TEST-COUNT
    CALL "USER" USING "READ" INPUT RESULT

    IF RESULT CONTAINS "data"
        ADD 1 TO PASSED
    END-IF

    DISPLAY "Testes: " TEST-COUNT " Passaram: " PASSED

    GOBACK.
```

---

## 📈 Escalabilidade | Scalability

### Horizontal | Horizontal

```
Load Balancer
    ├── Instância 1 (Laracol)
    ├── Instância 2 (Laracol)
    └── Instância 3 (Laracol)
         ↓
    Banco de Dados Compartilhado
    Cache Distribuído (Redis)
```

### Vertical | Vertical

```
Otimizações:
- Compilar com -O2 (otimização)
- Pool de conexões
- Cache em memória
- Índices no banco
- Lazy loading
```

---

## 🎓 Resumo | Summary

| Componente | Responsabilidade   | Padrão           |
| ---------- | ------------------ | ---------------- |
| Model      | CRUD e dados       | Active Record    |
| Controller | Requisição HTTP    | MVC              |
| Service    | Lógica negócio     | Strategy         |
| Middleware | Filtrar requisição | Filter           |
| Provider   | Bootstrap          | Factory          |
| Router     | Mapear URLs        | Pattern Matching |
| View       | Resposta JSON      | Template         |

---

## 📚 Próximos Passos | Next Steps

1. Leia [INSTALL.md](INSTALL.md) - Instale o framework
2. Siga [CRUD.md](CRUD.md) - Crie seu primeiro CRUD
3. Explore [../app/](../app/) - Entenda cada componente
4. Escreva testes - [../tests/](../tests/)

---

**Parabéns! Você entende a arquitetura do Laracol! 🎉**

**Congratulations! You understand Laracol's architecture! 🎉**
