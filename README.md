# Laracol - API REST Framework em COBOL

📋 **Português BR:** Laracol é um framework moderno para criar APIs REST em COBOL, inspirado no Laravel. Oferece uma estrutura MVC clara, roteamento inteligente, e componentes reutilizáveis.

📋 **English:** Laracol is a modern framework for creating REST APIs in COBOL, inspired by Laravel. It offers a clear MVC structure, intelligent routing, and reusable components.

---

## Português BR - Guia Rápido

### O que é Laracol?

Laracol é uma adaptação do padrão Laravel para COBOL, fornecendo:

- ✅ Arquitetura MVC modular
- ✅ Roteamento REST inteligente
- ✅ Sistema de controllers e models
- ✅ Services para lógica de negócio
- ✅ Middleware para processamento de requisições
- ✅ Providers para inicialização de serviços
- ✅ Migrations para versionamento de BD
- ✅ Sistema de logging estruturado

### Estrutura do Projeto

```
laracol/
├── app/                  # Lógica principal
│   ├── Http/            # Controllers e Middleware
│   ├── Models/          # Modelos de dados
│   ├── Services/        # Lógica de negócio
│   └── Providers/       # Inicializadores
├── bootstrap/           # Inicialização
├── config/              # Configurações
├── database/            # Migrations e seeders
├── public/              # Entrada HTTP (CGI)
├── resources/           # Views e templates
├── routes/              # Definição de rotas
├── storage/             # Logs e uploads
├── tests/               # Testes automatizados
├── bin/                 # Binários compilados
├── Makefile             # Comandos de build
└── README.md            # Este arquivo
```

### Começar Rápido

```bash
# Setup inicial
make setup

# Compilar aplicação
make build

# Executar
make run

# Limpar
make clean
```

### Exemplo: Criar um Novo Endpoint

1. **Criar um Controller** (`app/Http/Controllers/PostController.cbl`):

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. POSTCONTROLLER.

      *> Comentário: Controller para posts
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 RESPONSE-DATA PIC X(500).

       PROCEDURE DIVISION.

           DISPLAY "Content-Type: application/json"
           DISPLAY " "

           MOVE '{"data":[{"id":1,"title":"Meu Post"}]}'
               TO RESPONSE-DATA

           DISPLAY RESPONSE-DATA

           GOBACK.
```

2. **Registrar na Rota** (em `routes/api.cbl`):

```cobol
       WHEN REQ-METHOD = "GET" AND REQ-PATH = "/api/posts"
           CALL "POSTCONTROLLER" USING RESULT-DATA
```

3. **Compilar e Testar**:

```bash
make build
curl http://localhost:8080/api/posts
```

### 📚 Documentação Principal | Main Documentation

---

**📖 LEIA PRIMEIRO! | READ FIRST!**

Pasta com documentação prática e conceitual:
Folder with practical and conceptual documentation:

- 📘 [**docs/INSTALL.md**](docs/INSTALL.md) - Como instalar | Installation guide
- 📙 [**docs/CRUD.md**](docs/CRUD.md) - Criar CRUD REST | Create REST CRUD
- 📗 [**docs/FRAMEWORK.md**](docs/FRAMEWORK.md) - Entender o framework | Understanding the framework
- 📑 [**docs/README.md**](docs/README.md) - Índice de documentação | Documentation index

---

### Documentação por Diretório | Directory Documentation

| Diretório        | Descrição                  | Guia                           |
| ---------------- | -------------------------- | ------------------------------ |
| `docs/`          | **Documentação principal** | [Ver](docs/README.md)          |
| `app/`           | Lógica principal           | [Ver](app/README.md)           |
| `app/Http/`      | Controllers e Middleware   | [Ver](app/Http/README.md)      |
| `app/Models/`    | Modelos de dados           | [Ver](app/Models/README.md)    |
| `app/Services/`  | Serviços                   | [Ver](app/Services/README.md)  |
| `app/Providers/` | Providers                  | [Ver](app/Providers/README.md) |
| `bootstrap/`     | Inicialização              | [Ver](bootstrap/README.md)     |
| `config/`        | Configurações              | [Ver](config/README.md)        |
| `database/`      | Migrations                 | [Ver](database/README.md)      |
| `public/`        | CGI e Web                  | [Ver](public/README.md)        |
| `resources/`     | Views                      | [Ver](resources/README.md)     |
| `routes/`        | Rotas                      | [Ver](routes/README.md)        |
| `storage/`       | Logs e uploads             | [Ver](storage/README.md)       |
| `tests/`         | Testes                     | [Ver](tests/README.md)         |
| `bin/`           | Binários                   | [Ver](bin/README.md)           |

---

## English - Quick Start Guide

### What is Laracol?

Laracol is an adaptation of the Laravel pattern for COBOL, providing:

- ✅ Modular MVC architecture
- ✅ Intelligent REST routing
- ✅ Controllers and models system
- ✅ Services for business logic
- ✅ Middleware for request processing
- ✅ Providers for service initialization
- ✅ Migrations for database versioning
- ✅ Structured logging system

### Project Structure

```
laracol/
├── app/                  # Main logic
│   ├── Http/            # Controllers and Middleware
│   ├── Models/          # Data models
│   ├── Services/        # Business logic
│   └── Providers/       # Initializers
├── bootstrap/           # Initialization
├── config/              # Configuration
├── database/            # Migrations and seeders
├── public/              # HTTP entry (CGI)
├── resources/           # Views and templates
├── routes/              # Route definition
├── storage/             # Logs and uploads
├── tests/               # Automated tests
├── bin/                 # Compiled binaries
├── Makefile             # Build commands
└── README.md            # This file
```

### Quick Start

```bash
# Initial setup
make setup

# Compile application
make build

# Run
make run

# Clean
make clean
```

### Example: Create a New Endpoint

1. **Create a Controller** (`app/Http/Controllers/CommentController.cbl`):

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. COMMENTCONTROLLER.

      *> Comment: Controller for comments
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 RESPONSE-DATA PIC X(500).

       PROCEDURE DIVISION.

           DISPLAY "Content-Type: application/json"
           DISPLAY " "

           MOVE '{"data":[{"id":1,"text":"Great post!"}]}'
               TO RESPONSE-DATA

           DISPLAY RESPONSE-DATA

           GOBACK.
```

2. **Register in Route** (in `routes/api.cbl`):

```cobol
       WHEN REQ-METHOD = "GET" AND REQ-PATH = "/api/comments"
           CALL "COMMENTCONTROLLER" USING RESULT-DATA
```

3. **Compile and Test**:

```bash
make build
curl http://localhost:8080/api/comments
```

### Documentation by Directory

| Directory        | Description                | Guide                          |
| ---------------- | -------------------------- | ------------------------------ |
| `app/`           | Main logic                 | [See](app/README.md)           |
| `app/Http/`      | Controllers and Middleware | [See](app/Http/README.md)      |
| `app/Models/`    | Data models                | [See](app/Models/README.md)    |
| `app/Services/`  | Services                   | [See](app/Services/README.md)  |
| `app/Providers/` | Providers                  | [See](app/Providers/README.md) |
| `bootstrap/`     | Initialization             | [See](bootstrap/README.md)     |
| `config/`        | Configuration              | [See](config/README.md)        |
| `database/`      | Migrations                 | [See](database/README.md)      |
| `public/`        | CGI and Web                | [See](public/README.md)        |
| `resources/`     | Views                      | [See](resources/README.md)     |
| `routes/`        | Routes                     | [See](routes/README.md)        |
| `storage/`       | Logs and uploads           | [See](storage/README.md)       |
| `tests/`         | Tests                      | [See](tests/README.md)         |
| `bin/`           | Binaries                   | [See](bin/README.md)           |

---

## Fluxo de Requisição | Request Flow

```
HTTP Request
   ↓
CGI (public/index.cgi)
   ↓
HTTP Kernel (app/Http/Kernel.cbl)
   ↓
Middleware (app/Http/Middleware/)
   ↓
Router (routes/api.cbl)
   ↓
Controller (app/Http/Controllers/)
   ↓
Model (app/Models/) & Service (app/Services/)
   ↓
Response (JSON)
   ↓
HTTP Response
```

---

## Padrões de Nomes | Naming Patterns

### Português BR

| Tipo       | Padrão                  | Exemplo                     |
| ---------- | ----------------------- | --------------------------- |
| Controller | PascalCase + Controller | UserController.cbl          |
| Model      | PascalCase              | User.cbl                    |
| Service    | PascalCase + Service    | EmailService.cbl            |
| Provider   | PascalCase + Provider   | DatabaseProvider.cbl        |
| Middleware | PascalCase + Middleware | AuthMiddleware.cbl          |
| Migration  | timestamp_description   | 2024_03_13_create_users.cbl |
| Teste      | PascalCase + Test       | UserTest.cbl                |

### English

| Type       | Pattern                 | Example                        |
| ---------- | ----------------------- | ------------------------------ |
| Controller | PascalCase + Controller | ProductController.cbl          |
| Model      | PascalCase              | Product.cbl                    |
| Service    | PascalCase + Service    | PaymentService.cbl             |
| Provider   | PascalCase + Provider   | CacheProvider.cbl              |
| Middleware | PascalCase + Middleware | CorsMiddleware.cbl             |
| Migration  | timestamp_description   | 2024_03_13_create_products.cbl |
| Test       | PascalCase + Test       | ProductTest.cbl                |

---

## Comandos Makefile | Makefile Commands

```bash
# Português BR
make help          # Exibir ajuda
make setup         # Configuração inicial
make build         # Compilar
make run           # Compilar e executar
make clean         # Limpar binários
make test          # Executar testes

# English
make help          # Show help
make setup         # Initial setup
make build         # Compile
make run           # Compile and run
make clean         # Clean binaries
make test          # Run tests
```

---

## Requisitos | Requirements

### Sistema

- **CO**: GnuCOBOL 2.2+ ou OpenCOBOL
- **SO**: Linux, macOS, ou Windows (WSL/Cygwin)
- **Servidor Web**: Apache com suporte a CGI, ou Nginx com FastCGI

### System

- **Compiler**: GnuCOBOL 2.2+ or OpenCOBOL
- **OS**: Linux, macOS, or Windows (WSL/Cygwin)
- **Web Server**: Apache with CGI support, or Nginx with FastCGI

### Instalar GnuCOBOL

```bash
# Ubuntu/Debian
sudo apt-get install gnucobol

# macOS
brew install gnucobol

# Verificar instalação
cobc --version
```

---

## Exemplo Completo | Complete Example

### 1. Criar Model (app/Models/Note.cbl)

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. NOTE.

      *> Comentário: Modelo de nota
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 NOTE-RECORD.
           05 NOTE-ID PIC 9(5).
           05 NOTE-TEXT PIC X(500).

       LINKAGE SECTION.
       01 ACTION PIC X(20).
       01 DATA-INPUT PIC X(500).
       01 RESULT-OUTPUT PIC X(500).

       PROCEDURE DIVISION USING ACTION DATA-INPUT RESULT-OUTPUT.

           EVALUATE ACTION
               WHEN "READ"
                   MOVE '{"id":1,"text":"Minha nota"}' TO RESULT-OUTPUT
           END-EVALUATE

           GOBACK.
```

### 2. Criar Controller (app/Http/Controllers/NoteController.cbl)

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. NOTECONTROLLER.

      *> Comentário: Controller de notas
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 RESPONSE-DATA PIC X(500).

       PROCEDURE DIVISION.

           DISPLAY "Content-Type: application/json"
           DISPLAY " "

           CALL "NOTE" USING "READ" "" RESPONSE-DATA

           DISPLAY RESPONSE-DATA

           GOBACK.
```

### 3. Registrar Rota (routes/api.cbl)

```cobol
       WHEN REQ-METHOD = "GET" AND REQ-PATH = "/api/notes"
           CALL "NOTECONTROLLER" USING RESULT-DATA
```

### 4. Compilar e Executar

```bash
make build
make run

# Testar em outro terminal
curl http://localhost:8080/api/notes
```

---

## Suporte | Support

Para dúvidas ou problemas:

- 📖 Consulte a documentação em cada diretório
- 💬 Veja os comentários nos arquivos de exemplo
- 🐛 Verifique o arquivo de logs em `storage/logs/`
- 🔍 Use `make clean && make build` para reconstruir tudo

For questions or issues:

- 📖 Check the documentation in each directory
- 💬 See the comments in example files
- 🐛 Check the log file in `storage/logs/`
- 🔍 Use `make clean && make build` to rebuild everything

---

## Versão | Version

**Laracol**: 1.0.0  
**Compatibilidade**: GnuCOBOL 2.2+  
**Última Atualização**: 13 de Março de 2024  
**Last Update**: March 13, 2024

---

## Licença | License

Este projeto é fornecido como está para fins educacionais e de desenvolvimento.

This project is provided as-is for educational and development purposes.

---

**Criado com ❤️ para desenvolvedores COBOL | Created with ❤️ for COBOL developers**
# laracol
