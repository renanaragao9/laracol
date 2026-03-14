# Database | Banco de Dados

📋 **Português BR:** Diretório contendo migrations e seeders para gerenciar o banco de dados da aplicação.

📋 **English:** Directory containing migrations and seeders to manage the application database.

---

## Português BR - Estrutura de Banco de Dados

### O que é Migration?

Migrations são programas COBOL que descrevem alterações estruturais no banco de dados. Elas permitem versionamento e reversão de mudanças no schema.

### Estrutura do Diretório

```
database/
├── migrations/      - Alterações de schema
├── seeders/         - Dados iniciais (seeds)
└── README.md        - Este arquivo
```

### Exemplo de Migration

Arquivo `database/migrations/2024_03_13_create_users_table.cbl`:

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CREATE-USERS-TABLE.

      *> Comentário: Migration para criar tabela users
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 SQL-CREATE-TABLE PIC X(500) VALUE
           "CREATE TABLE IF NOT EXISTS users ("
           "  id INTEGER PRIMARY KEY AUTOINCREMENT,"
           "  name TEXT NOT NULL,"
           "  email TEXT UNIQUE NOT NULL,"
           "  password TEXT NOT NULL,"
           "  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"
           "  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP"
           ");".

       01 SQL-CREATE-INDEX PIC X(500) VALUE
           "CREATE INDEX IF NOT EXISTS idx_users_email "
           "ON users(email);".

       01 MIGRATION-STATUS PIC X(50).

       PROCEDURE DIVISION.

      *> Comentário: Executa DDL para criar tabela
           DISPLAY "Executando migration: criar tabela users..."

      *> Comentário em português: Aqui seria executado SQL
           MOVE "Migration executed successfully" TO MIGRATION-STATUS
           DISPLAY MIGRATION-STATUS

           GOBACK.
```

### Naming Convention para Migrations

```
<TIMESTAMP>_<DESCRIPTION>.cbl

Exemplos:
2024_03_13_create_users_table.cbl
2024_03_13_create_products_table.cbl
2024_03_13_add_email_to_users.cbl
```

### Exemplo de Seeder

Arquivo `database/seeders/UsersTableSeeder.cbl`:

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. USERSTABLESEEDER.

      *> Comentário: Seeder para popular tabela users
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 SQL-INSERT PIC X(500) VALUE
           "INSERT INTO users (name, email, password) "
           "VALUES ('Admin', 'admin@laracol.com', 'hashed');"

       01 SEEDER-STATUS PIC X(50).

       PROCEDURE DIVISION.

      *> Comentário: Insere dados iniciais
           DISPLAY "Executando seeder UsersTableSeeder..."

           MOVE "Seeder executed successfully" TO SEEDER-STATUS
           DISPLAY SEEDER-STATUS

           GOBACK.
```

---

## English - Database Structure

### What is a Migration?

Migrations are COBOL programs that describe structural changes to the database. They allow versioning and reversal of schema changes.

### Directory Structure

```
database/
├── migrations/      - Schema changes
├── seeders/         - Initial data (seeds)
└── README.md        - This file
```

### Example of Migration

File `database/migrations/2024_03_13_create_products_table.cbl`:

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CREATE-PRODUCTS-TABLE.

      *> Comment: Migration to create products table
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 SQL-CREATE-TABLE PIC X(500) VALUE
           "CREATE TABLE IF NOT EXISTS products ("
           "  id INTEGER PRIMARY KEY AUTOINCREMENT,"
           "  name TEXT NOT NULL,"
           "  description TEXT,"
           "  price DECIMAL(10,2) NOT NULL,"
           "  stock INTEGER DEFAULT 0,"
           "  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"
           "  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP"
           ");".

       01 SQL-CREATE-INDEX PIC X(500) VALUE
           "CREATE INDEX IF NOT EXISTS idx_products_name "
           "ON products(name);".

       01 MIGRATION-STATUS PIC X(50).

       PROCEDURE DIVISION.

      *> Comment: Execute DDL to create table
           DISPLAY "Running migration: create products table..."

      *> Comment in English: SQL would be executed here
           MOVE "Migration executed successfully" TO MIGRATION-STATUS
           DISPLAY MIGRATION-STATUS

           GOBACK.
```

### Naming Convention for Migrations

```
<TIMESTAMP>_<DESCRIPTION>.cbl

Examples:
2024_03_13_create_users_table.cbl
2024_03_13_create_products_table.cbl
2024_03_13_add_status_to_products.cbl
```

### Example of Seeder

File `database/seeders/ProductsTableSeeder.cbl`:

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRODUCTSTABLESEEDER.

      *> Comment: Seeder to populate products table
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 SQL-INSERT PIC X(500) VALUE
           "INSERT INTO products (name, description, price) "
           "VALUES ('Laptop', 'High-performance laptop', 2499.99);"

       01 SEEDER-STATUS PIC X(50).

       PROCEDURE DIVISION.

      *> Comment: Insert initial data
           DISPLAY "Running seeder ProductsTableSeeder..."

           MOVE "Seeder executed successfully" TO SEEDER-STATUS
           DISPLAY SEEDER-STATUS

           GOBACK.
```

---

## Execução de Migrations | Running Migrations

```bash
# Português BR - Executar todas as migrations
make migrate

# Run up migrations
make migrate-up

# Rollback dernière migration
make migrate-down

# Run all seeders
make seed
```

## Estrutura Recomendada | Recommended Structure

```
database/
├── migrations/
│   ├── 2024_03_13_create_users_table.cbl
│   ├── 2024_03_13_create_products_table.cbl
│   └── 2024_03_14_create_orders_table.cbl
├── seeders/
│   ├── UsersTableSeeder.cbl
│   ├── ProductsTableSeeder.cbl
│   └── DatabaseSeeder.cbl
└── README.md
```

## Boas Práticas | Best Practices

1. **Nomeação**: Use timestamps para garantir ordem de execução
2. **Descritivo**: Use nomes descritivos para entender o que a migration faz
3. **Reversível**: Sempre crie forma de reverter a migration
4. **Modular**: Uma migration = uma mudança
5. **Testável**: Teste migrations antes de fazer deploy

6. **Naming**: Use timestamps to ensure execution order
7. **Descriptive**: Use descriptive names to understand what migration does
8. **Reversible**: Always create a way to revert the migration
9. **Modular**: One migration = one change
10. **Testable**: Test migrations before deploying
