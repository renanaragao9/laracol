# App | Aplicação

📋 **Português BR:** Diretório raiz da aplicação Laracol. Contém a lógica central incluindo controllers, models, services e providers.

📋 **English:** Root directory of the Laracol application. Contains the core logic including controllers, models, services, and providers.

---

## Português BR - Estrutura da Aplicação

### Componentes Principais

A estrutura de diretórios do `app/` segue o padrão MVC adaptado para COBOL:

```
app/
├── Http/              - Camada HTTP (Controllers, Middleware, Kernel)
├── Models/            - Modelos de dados (CRUD)
├── Services/          - Lógica de negócio reutilizável
├── Providers/         - Inicializadores de serviços
└── README.md          - Este arquivo
```

### Fluxo de Requisição

```
1. Requisição HTTP chega no Kernel
   ↓
2. Middleware processa a requisição
   ↓
3. Router (em routes/api.cbl) define o controller
   ↓
4. Controller é executado
   ↓
5. Controller pode usar Models e Services
   ↓
6. Resposta é retornada ao cliente
```

### Exemplo de Fluxo Completo

Para uma requisição `GET /api/users/1`:

```cobol
1. HTTPKERNEL.cbl recebe a requisição
2. AUTHMIDDLEWARE.cbl valida o token
3. Router em routes/api.cbl mapeia para USERCONTROLLER
4. USERCONTROLLER executa
5. USER models é chamado com ACTION = "READ"
6. USER retorna dados do banco
7. Resposta JSON é enviada ao cliente
```

### Padrão de Nomes

| Tipo       | Padrão                  | Exemplo               |
| ---------- | ----------------------- | --------------------- |
| Controller | PascalCase + Controller | UserController.cbl    |
| Model      | PascalCase              | User.cbl, Product.cbl |
| Service    | PascalCase + Service    | EmailService.cbl      |
| Provider   | PascalCase + Provider   | DatabaseProvider.cbl  |
| Middleware | PascalCase + Middleware | AuthMiddleware.cbl    |

---

## English - Application Structure

### Main Components

The directory structure of `app/` follows the MVC pattern adapted for COBOL:

```
app/
├── Http/              - HTTP layer (Controllers, Middleware, Kernel)
├── Models/            - Data models (CRUD)
├── Services/          - Reusable business logic
├── Providers/         - Service initializers
└── README.md          - This file
```

### Request Flow

```
1. HTTP request arrives at Kernel
   ↓
2. Middleware processes the request
   ↓
3. Router (in routes/api.cbl) defines the controller
   ↓
4. Controller is executed
   ↓
5. Controller can use Models and Services
   ↓
6. Response is returned to the client
```

### Complete Flow Example

For a request `GET /api/users/1`:

```cobol
1. HTTPKERNEL.cbl receives the request
2. AUTHMIDDLEWARE.cbl validates the token
3. Router in routes/api.cbl maps to USERCONTROLLER
4. USERCONTROLLER executes
5. USER model is called with ACTION = "READ"
6. USER returns data from database
7. JSON response is sent to the client
```

### Naming Pattern

| Type       | Pattern                 | Example               |
| ---------- | ----------------------- | --------------------- |
| Controller | PascalCase + Controller | UserController.cbl    |
| Model      | PascalCase              | User.cbl, Product.cbl |
| Service    | PascalCase + Service    | EmailService.cbl      |
| Provider   | PascalCase + Provider   | DatabaseProvider.cbl  |
| Middleware | PascalCase + Middleware | AuthMiddleware.cbl    |

---

## Diretórios Relacionados | Related Directories

Para mais informações sobre cada componente:

- [Http/](Http/README.md) - Camada HTTP
- [Http/Controllers/](Http/Controllers/README.md) - Controllers
- [Http/Middleware/](Http/Middleware/README.md) - Middleware
- [Models/](Models/README.md) - Modelos de dados
- [Services/](Services/README.md) - Serviços
- [Providers/](Providers/README.md) - Providers

For more information about each component:

- [Http/](Http/README.md) - HTTP Layer
- [Http/Controllers/](Http/Controllers/README.md) - Controllers
- [Http/Middleware/](Http/Middleware/README.md) - Middleware
- [Models/](Models/README.md) - Data Models
- [Services/](Services/README.md) - Services
- [Providers/](Providers/README.md) - Providers
