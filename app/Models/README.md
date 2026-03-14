# Models | Modelos

📋 **Português BR:** Models são programas COBOL que representam e gerenciam dados da aplicação. Eles encapsulam a lógica de acesso a banco de dados e validação de dados.

📋 **English:** Models are COBOL programs that represent and manage application data. They encapsulate database access logic and data validation.

---

## Português BR - Guia de Uso

### O que é um Model?

Um Model é um programa COBOL que representa uma tabela ou entidade no banco de dados. Ele fornece métodos para criar, ler, atualizar e deletar registros (operações CRUD).

### Exemplo de Criar um Model

Para criar um novo model chamado `User.cbl`:

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. USER.

      *> Comentário em português: Model para tabela de usuários
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 USER-RECORD.
           05 USER-ID PIC 9(5).
           05 USER-NAME PIC X(100).
           05 USER-EMAIL PIC X(100).
           05 USER-PASSWORD PIC X(255).
           05 CREATED-AT PIC X(20).

       01 SQL-STMT PIC X(500).
       01 DATABASE-PATH PIC X(100) VALUE "database/app.db".

       LINKAGE SECTION.
       01 ACTION PIC X(20).
       01 DATA-INPUT PIC X(500).
       01 RESULT-OUTPUT PIC X(500).

       PROCEDURE DIVISION USING ACTION DATA-INPUT RESULT-OUTPUT.

      *> Comentário: Processa diferentes ações CRUD
           EVALUATE ACTION
               WHEN "CREATE"
                   PERFORM CREATE-USER
               WHEN "READ"
                   PERFORM READ-USER
               WHEN "UPDATE"
                   PERFORM UPDATE-USER
               WHEN "DELETE"
                   PERFORM DELETE-USER
               WHEN OTHER
                   MOVE '{"error":"Ação inválida"}' TO RESULT-OUTPUT
           END-EVALUATE

           GOBACK.

       CREATE-USER.
           MOVE '{"status":"usuario criado","id":1}' TO RESULT-OUTPUT.

       READ-USER.
           MOVE '{"id":1,"name":"João","email":"joao@email.com"}'
               TO RESULT-OUTPUT.

       UPDATE-USER.
           MOVE '{"status":"usuario atualizado"}' TO RESULT-OUTPUT.

       DELETE-USER.
           MOVE '{"status":"usuario deletado"}' TO RESULT-OUTPUT.
```

### Padrão de Nomenclatura

1. **Arquivo**: Use nomes singulares em CamelCase (exemplo: `User.cbl`, `Product.cbl`, `Order.cbl`)
2. **PROGRAM-ID**: Deve corresponder ao nome do arquivo
3. **Estrutura de Dados**: Use nomes descritivos para campos

### Estrutura Recomendada

```
Models/
├── BaseModel.cbl (classe base)
├── User.cbl
├── Product.cbl
├── Order.cbl
└── README.md (este arquivo)
```

---

## English - Usage Guide

### What is a Model?

A Model is a COBOL program that represents a table or entity in the database. It provides methods to create, read, update, and delete records (CRUD operations).

### Example of Creating a Model

To create a new model called `Product.cbl`:

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRODUCT.

      *> Comment in English: Model for products table
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 PRODUCT-RECORD.
           05 PRODUCT-ID PIC 9(5).
           05 PRODUCT-NAME PIC X(100).
           05 PRODUCT-DESCRIPTION PIC X(500).
           05 PRODUCT-PRICE PIC 9(7)V99.
           05 STOCK-QUANTITY PIC 9(7).
           05 CREATED-AT PIC X(20).

       01 SQL-STMT PIC X(500).
       01 DATABASE-PATH PIC X(100) VALUE "database/app.db".

       LINKAGE SECTION.
       01 ACTION PIC X(20).
       01 DATA-INPUT PIC X(500).
       01 RESULT-OUTPUT PIC X(500).

       PROCEDURE DIVISION USING ACTION DATA-INPUT RESULT-OUTPUT.

      *> Comment: Processes different CRUD actions
           EVALUATE ACTION
               WHEN "CREATE"
                   PERFORM CREATE-PRODUCT
               WHEN "READ"
                   PERFORM READ-PRODUCT
               WHEN "UPDATE"
                   PERFORM UPDATE-PRODUCT
               WHEN "DELETE"
                   PERFORM DELETE-PRODUCT
               WHEN OTHER
                   MOVE '{"error":"Invalid action"}' TO RESULT-OUTPUT
           END-EVALUATE

           GOBACK.

       CREATE-PRODUCT.
           MOVE '{"status":"product created","id":1}' TO RESULT-OUTPUT.

       READ-PRODUCT.
           MOVE '{"id":1,"name":"Laptop","price":2499.99}'
               TO RESULT-OUTPUT.

       UPDATE-PRODUCT.
           MOVE '{"status":"product updated"}' TO RESULT-OUTPUT.

       DELETE-PRODUCT.
           MOVE '{"status":"product deleted"}' TO RESULT-OUTPUT.
```

### Naming Pattern

1. **File**: Use singular names in CamelCase (example: `User.cbl`, `Product.cbl`, `Order.cbl`)
2. **PROGRAM-ID**: Must match the filename
3. **Data Structure**: Use descriptive names for fields

### Recommended Structure

```
Models/
├── BaseModel.cbl (base class)
├── User.cbl
├── Product.cbl
├── Order.cbl
└── README.md (this file)
```

---

## Operações CRUD | CRUD Operations

Todos os models devem suportar:

All models should support:

- **CREATE**: Inserir novo registro
- **READ**: Ler/buscar registros
- **UPDATE**: Atualizar registro existente
- **DELETE**: Deletar registro
