# 📚 Documentação do Laracol

**Português BR:** Centro de documentação do Laracol Framework com guias práticos e conceituais.

**English:** Documentation center for the Laracol Framework with practical and conceptual guides.

---

## 📖 Índice de Documentação | Documentation Index

### 🚀 Guias Iniciais | Getting Started

1. **[INSTALL.md](INSTALL.md)** - Como instalar o Laracol
   - Pré-requisitos | Prerequisites
   - Instalação compilador | Compiler installation
   - Configuração inicial | Initial setup
   - Troubleshooting

2. **[CRUD.md](CRUD.md)** - Criar seu primeiro CRUD REST
   - Exemplo prático: Sistema de Tarefas | Practical example: Task System
   - Passo a passo | Step by step
   - Testes com curl | Testing with curl
   - Postman collection

3. **[FRAMEWORK.md](FRAMEWORK.md)** - Entender o framework
   - Arquitetura MVC | MVC Architecture
   - Padrões de design | Design patterns
   - Ciclo de vida | Application lifecycle
   - Boas práticas | Best practices

---

## 📂 Estrutura de Diretórios | Directory Structure

```
docs/
├── README.md          - Este arquivo | This file
├── INSTALL.md         - Instalação | Installation
├── CRUD.md            - Criar CRUD REST | Create REST CRUD
├── FRAMEWORK.md       - Explicação do framework | Framework explanation
└── images/            - Diagramas e imagens | Diagrams and images (opcional)
```

---

## 🎯 Escolha seu Caminho | Choose Your Path

### Sou Iniciante | I'm a Beginner

```
1. Leia [INSTALL.md](INSTALL.md)
   └─ Instale o Laracol

2. Siga [CRUD.md](CRUD.md)
   └─ Crie seu primeiro endpoint REST

3. Estude [FRAMEWORK.md](FRAMEWORK.md)
   └─ Entenda como tudo funciona
```

### Estou Migrando do Laravel | I'm Migrating from Laravel

```
1. Leia [FRAMEWORK.md](FRAMEWORK.md)
   └─ Veja comparação com padrões Laravel

2. Siga [CRUD.md](CRUD.md)
   └─ Adapte seu conhecimento

3. Consulte [../app/](../app/)
   └─ Explore estrutura detalhada
```

### Quero Aprender Arquitetura | I Want to Learn Architecture

```
1. Estude [FRAMEWORK.md](FRAMEWORK.md)
   └─ Padrões e conceitos

2. Leia [../app/Http/README.md](../app/Http/README.md)
   └─ Camada HTTP

3. Explore [../app/Models/README.md](../app/Models/README.md)
   └─ Camada de Dados
```

---

## 📋 Documentação por Tipo | Documentation by Type

### Guias Práticos | Practical Guides

| Documento                | Tipo     | Tempo  |
| ------------------------ | -------- | ------ |
| [INSTALL.md](INSTALL.md) | Setup    | 15 min |
| [CRUD.md](CRUD.md)       | Hands-on | 30 min |

### Guias Conceituais | Conceptual Guides

| Documento                    | Foco        | Tempo  |
| ---------------------------- | ----------- | ------ |
| [FRAMEWORK.md](FRAMEWORK.md) | Arquitetura | 45 min |

### Referência Completa | Complete Reference

| Documento                                                              | Descrição           |
| ---------------------------------------------------------------------- | ------------------- |
| [../README.md](../README.md)                                           | Overview do projeto |
| [../app/README.md](../app/README.md)                                   | Estrutura app/      |
| [../app/Http/README.md](../app/Http/README.md)                         | Camada HTTP         |
| [../app/Http/Controllers/README.md](../app/Http/Controllers/README.md) | Controllers         |
| [../app/Models/README.md](../app/Models/README.md)                     | Models              |
| [../app/Services/README.md](../app/Services/README.md)                 | Services            |
| [../routes/README.md](../routes/README.md)                             | Rotas               |

---

## 🔑 Conceitos-Chave | Key Concepts

### Model

```cobol
Representa uma tabela do banco de dados
Implementa CRUD (Create, Read, Update, Delete)
Gerencia validações e relacionamentos
```

### Controller

```cobol
Recebe requisição HTTP
Processa dados (delega para Service)
Retorna resposta JSON
```

### Service

```cobol
Contém lógica de negócio
Reutilizável por múltiplos controllers
Independente de entrada/saída
```

### Middleware

```cobol
Intercepta requisição
Valida, autentica, autoriza
Pode rejeitar ou modificar requisição
```

### Router

```cobol
Mapeia URL + Método para Controller
Define endpoints da API
Suporta parâmetros dinâmicos
```

---

## 🚦 Quick Start (5 minutos) | Quick Start (5 minutes)

### Português BR

```bash
# 1. Instalar
cd ~
git clone https://github.com/seu-usuario/laracol.git
cd laracol
make setup

# 2. Compilar
make build

# 3. Executar
make run

# 4. Testar (outro terminal)
curl http://localhost:8080/api/welcome
```

### English

```bash
# 1. Install
cd ~
git clone https://github.com/your-username/laracol.git
cd laracol
make setup

# 2. Compile
make build

# 3. Run
make run

# 4. Test (another terminal)
curl http://localhost:8080/api/welcome
```

---

## 💾 Exemplo: Criar Endpoint em 3 Passos | Example: Create Endpoint in 3 Steps

### 1. Model (`app/Models/Article.cbl`)

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ARTICLE.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 ARTICLE PIC X(500).

       LINKAGE SECTION.
       01 ACTION PIC X(20).
       01 INPUT PIC X(500).
       01 OUTPUT PIC X(500).

       PROCEDURE DIVISION USING ACTION INPUT OUTPUT.
           EVALUATE ACTION
               WHEN "READ" MOVE '{"id":1,"title":"Artigo"}' TO OUTPUT
           END-EVALUATE
           GOBACK.
```

### 2. Controller (`app/Http/Controllers/ArticleController.cbl`)

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ARTICLECONTROLLER.

       PROCEDURE DIVISION.
           DISPLAY "Content-Type: application/json"
           DISPLAY " "
           CALL "ARTICLE" USING "READ" "" RESPONSE
           DISPLAY RESPONSE
           GOBACK.
```

### 3. Rota (`routes/api.cbl`)

```cobol
       WHEN REQ-METHOD = "GET" AND REQ-PATH = "/api/articles"
           CALL "ARTICLECONTROLLER" USING RESULT
```

**Pronto!** | **Done!** ✅

---

## 📊 Estatísticas | Statistics

| Item               | Quantidade           |
| ------------------ | -------------------- |
| Documentos         | 3 main + 14 detailed |
| Exemplos de Código | 50+                  |
| Padrões de Design  | 5                    |
| Endpoints Exemplo  | 10+                  |

---

## 🔗 Links Úteis | Useful Links

### Recursos Laracol | Laracol Resources

- [README Principal](../README.md) - Overview completo
- [Estrutura app/](../app/README.md) - Explicação da arquitetura
- [Guia de Controllers](../app/Http/Controllers/README.md)
- [Guia de Models](../app/Models/README.md)
- [Guia de Services](../app/Services/README.md)
- [Guia de Rotas](../routes/README.md)

### Referências Externas | External References

- 🔗 [GnuCOBOL Docs](https://www.gnu.org/software/gnucobol/)
- 🔗 [Laravel Documentation](https://laravel.com/docs) - Padrões similares
- 🔗 [REST API Best Practices](https://restfulapi.net/)
- 🔗 [HTTP Status Codes](https://httpwg.org/specs/rfc7231.html#status.codes)

---

## ❓ FAQ | Frequently Asked Questions

### P: Preciso saber Laravel para usar Laracol?

**R:** Não obrigatoriamente, mas ajuda. O framework adapt padrões do Laravel para COBOL.

### Q: Do I need to know Laravel to use Laracol?

**A:** Not necessarily, but it helps. The framework adapts Laravel patterns to COBOL.

---

### P: Qual banco de dados usar?

**R:** Por padrão SQLite, mas você pode usar PostgreSQL, MySQL ou qualquer outro.

### Q: Which database should I use?

**A:** SQLite by default, but you can use PostgreSQL, MySQL, or any other.

---

### P: Como conectar um banco de dados real?

**R:** Implemente SQL correspondente no seu Model. Veja [CRUD.md](CRUD.md) seção "Integrar com Banco".

### Q: How do I connect a real database?

**A:** Implement corresponding SQL in your Model. See [CRUD.md](CRUD.md) section "Integrate with Database".

---

### P: Preciso de autenticação?

**R:** Sim. Use Middleware para implementar JWT ou Basic Auth. Ver [../app/Http/Middleware/README.md](../app/Http/Middleware/README.md)

### Q: Do I need authentication?

**A:** Yes. Use Middleware to implement JWT or Basic Auth. See [../app/Http/Middleware/README.md](../app/Http/Middleware/README.md)

---

## 📝 Convenções | Conventions

### Nomes de Arquivo | File Names

```
Controllers:  PascalCase + Controller  (UserController.cbl)
Models:       PascalCase               (User.cbl)
Services:     PascalCase + Service     (EmailService.cbl)
Middleware:   PascalCase + Middleware  (AuthMiddleware.cbl)
Tests:        PascalCase + Test        (UserTest.cbl)
```

### Endpoints REST | REST Endpoints

```
GET    /api/resource        - Listar todos | List all
POST   /api/resource        - Criar novo | Create new
GET    /api/resource/:id    - Buscar ID | Get by ID
PUT    /api/resource/:id    - Atualizar | Update
DELETE /api/resource/:id    - Deletar | Delete
```

### Respostas JSON | JSON Responses

```json
{
  "status": "success|error",
  "message": "Mensagem descritiva",
  "data": {},
  "timestamp": "2024-03-13T10:30:00Z"
}
```

---

## 🎓 Caminho de Aprendizado | Learning Path

```
1. Semana 1 - Fundamentos
   ├─ Instalar [INSTALL.md]
   ├─ Primeiro CRUD [CRUD.md]
   └─ Entender arquitetura [FRAMEWORK.md]

2. Semana 2 - Desenvolvimento
   ├─ Criar Models avançados
   ├─ Implementar Services
   └─ Escrever testes

3. Semana 3 - Produção
   ├─ Adicionar autenticação
   ├─ Otimizar banco de dados
   └─ Deploy
```

---

## 🆘 Precisa de Ajuda? | Need Help?

### Português BR

1. **Verifique os logs**

   ```bash
   tail -f storage/logs/application.log
   ```

2. **Releia a documentação**
   - Comece com [INSTALL.md](INSTALL.md)
   - Siga com [CRUD.md](CRUD.md)
   - Estude [FRAMEWORK.md](FRAMEWORK.md)

3. **Reconstrua tudo**
   ```bash
   make clean
   make setup
   make build
   make run
   ```

### English

1. **Check the logs**

   ```bash
   tail -f storage/logs/application.log
   ```

2. **Re-read the documentation**
   - Start with [INSTALL.md](INSTALL.md)
   - Continue with [CRUD.md](CRUD.md)
   - Study [FRAMEWORK.md](FRAMEWORK.md)

3. **Rebuild everything**
   ```bash
   make clean
   make setup
   make build
   make run
   ```

---

## 📈 Próximas Leituras | Next Reading

- **Iniciante**: [INSTALL.md](INSTALL.md) → [CRUD.md](CRUD.md)
- **Intermediário**: [FRAMEWORK.md](FRAMEWORK.md) → Explore `app/` folders
- **Avançado**: [../tests/README.md](../tests/README.md) → Deploy

---

## 📞 Suporte | Support

Para dúvidas ou sugestões sobre a documentação:

1. Consulte a FAQ acima
2. Revise os exemplos em [CRUD.md](CRUD.md)
3. Estude [FRAMEWORK.md](FRAMEWORK.md) para conceitos
4. Explore a documentação detalhada em cada pasta

For questions or suggestions about the documentation:

1. Check the FAQ above
2. Review examples in [CRUD.md](CRUD.md)
3. Study [FRAMEWORK.md](FRAMEWORK.md) for concepts
4. Explore detailed documentation in each folder

---

**Bem-vindo ao Laracol! Happy Coding! 🚀**

**Welcome to Laracol! Happy Coding! 🚀**
