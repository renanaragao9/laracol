# Tests | Testes

📋 **Português BR:** Diretório contendo testes automatizados da aplicação. Inclui testes unitários, integração e ponta a ponta.

📋 **English:** Directory containing automated application tests. Includes unit tests, integration tests, and end-to-end tests.

---

## Português BR - Estrutura de Testes

### O que é um Teste?

Um teste é um programa que verifica se uma parte da aplicação funciona corretamente. Existem três tipos principais:

1. **Unitários**: Testam funções/métodos isolados
2. **Integração**: Testam múltiplos componentes juntos
3. **Ponta a Ponta**: Testam fluxos completos

### Estrutura Recomendada

```
tests/
├── Unit/                - Testes unitários
│   ├── UserTest.cbl
│   ├── ProductTest.cbl
│   └── README.md
├── Integration/         - Testes de integração
│   ├── DatabaseTest.cbl
│   ├── APITest.cbl
│   └── README.md
├── Feature/            - Testes de funcionalidade
│   ├── UserFlowTest.cbl
│   └── README.md
└── README.md           - Este arquivo
```

### Exemplo de Teste Unitário

Arquivo `tests/Unit/UserTest.cbl`:

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. USERTEST.

      *> Comentário: Testes para modelo User
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 TEST-RESULT PIC X VALUE 'Y'.
       01 TEST-COUNT PIC 9(3) VALUE 0.
       01 PASSED PIC 9(3) VALUE 0.
       01 FAILED PIC 9(3) VALUE 0.

       01 USER-DATA PIC X(500).
       01 EXPECTED-RESULT PIC X(500).
       01 ACTUAL-RESULT PIC X(500).

       PROCEDURE DIVISION.

      *> Comentário: Inicia testes
           DISPLAY "Iniciando testes unitários do User..."
           DISPLAY " "

      *> Comentário: Teste 1 - Criar usuário
           PERFORM TEST-CREATE-USER
           PERFORM TEST-READ-USER
           PERFORM TEST-UPDATE-USER
           PERFORM TEST-DELETE-USER

      *> Comentário: Exibe resultado final
           DISPLAY " "
           DISPLAY "Testes concluídos:"
           DISPLAY "  Total: " & TEST-COUNT
           DISPLAY "  Sucesso: " & PASSED
           DISPLAY "  Falhas: " & FAILED

           GOBACK.

       TEST-CREATE-USER.
           ADD 1 TO TEST-COUNT
           DISPLAY "Teste 1: Criar usuário..."

           MOVE '{"name":"João","email":"joao@test.com"}'
               TO USER-DATA

           CALL "USER" USING "CREATE" USER-DATA ACTUAL-RESULT

           IF ACTUAL-RESULT CONTAINS "status"
               ADD 1 TO PASSED
               DISPLAY "  ✓ Passou"
           ELSE
               ADD 1 TO FAILED
               DISPLAY "  ✗ Falhou"
           END-IF.

       TEST-READ-USER.
           ADD 1 TO TEST-COUNT
           DISPLAY "Teste 2: Ler usuário..."

           CALL "USER" USING "READ" USER-DATA ACTUAL-RESULT

           IF ACTUAL-RESULT CONTAINS "id"
               ADD 1 TO PASSED
               DISPLAY "  ✓ Passou"
           ELSE
               ADD 1 TO FAILED
               DISPLAY "  ✗ Falhou"
           END-IF.

       TEST-UPDATE-USER.
           ADD 1 TO TEST-COUNT
           DISPLAY "Teste 3: Atualizar usuário..."

           MOVE '{"id":1,"name":"João Silva"}'
               TO USER-DATA

           CALL "USER" USING "UPDATE" USER-DATA ACTUAL-RESULT

           IF ACTUAL-RESULT CONTAINS "status"
               ADD 1 TO PASSED
               DISPLAY "  ✓ Passou"
           ELSE
               ADD 1 TO FAILED
               DISPLAY "  ✗ Falhou"
           END-IF.

       TEST-DELETE-USER.
           ADD 1 TO TEST-COUNT
           DISPLAY "Teste 4: Deletar usuário..."

           CALL "USER" USING "DELETE" USER-DATA ACTUAL-RESULT

           IF ACTUAL-RESULT CONTAINS "deleted"
               ADD 1 TO PASSED
               DISPLAY "  ✓ Passou"
           ELSE
               ADD 1 TO FAILED
               DISPLAY "  ✗ Falhou"
           END-IF.
```

### Executar Testes

```bash
# Compilar e executar todos os testes
make test

# Executar testes unitários
make test-unit

# Executar testes de integração
make test-integration

# Executar com cobertura
make test-coverage
```

---

## English - Test Structure

### What is a Test?

A test is a program that verifies if a part of the application works correctly. There are three main types:

1. **Unit**: Test isolated functions/methods
2. **Integration**: Test multiple components together
3. **End-to-End**: Test complete flows

### Recommended Structure

```
tests/
├── Unit/                - Unit tests
│   ├── UserTest.cbl
│   ├── ProductTest.cbl
│   └── README.md
├── Integration/         - Integration tests
│   ├── DatabaseTest.cbl
│   ├── APITest.cbl
│   └── README.md
├── Feature/            - Feature tests
│   ├── UserFlowTest.cbl
│   └── README.md
└── README.md           - This file
```

### Example of Unit Test

File `tests/Unit/ProductTest.cbl`:

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRODUCTTEST.

      *> Comment: Tests for Product model
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 TEST-RESULT PIC X VALUE 'Y'.
       01 TEST-COUNT PIC 9(3) VALUE 0.
       01 PASSED PIC 9(3) VALUE 0.
       01 FAILED PIC 9(3) VALUE 0.

       01 PRODUCT-DATA PIC X(500).
       01 EXPECTED-RESULT PIC X(500).
       01 ACTUAL-RESULT PIC X(500).

       PROCEDURE DIVISION.

      *> Comment: Start tests
           DISPLAY "Starting Product model unit tests..."
           DISPLAY " "

      *> Comment: Test 1 - Create product
           PERFORM TEST-CREATE-PRODUCT
           PERFORM TEST-READ-PRODUCT
           PERFORM TEST-UPDATE-PRODUCT
           PERFORM TEST-DELETE-PRODUCT

      *> Comment: Display final results
           DISPLAY " "
           DISPLAY "Tests completed:"
           DISPLAY "  Total: " & TEST-COUNT
           DISPLAY "  Passed: " & PASSED
           DISPLAY "  Failed: " & FAILED

           GOBACK.

       TEST-CREATE-PRODUCT.
           ADD 1 TO TEST-COUNT
           DISPLAY "Test 1: Create product..."

           MOVE '{"name":"Laptop","price":2499.99}'
               TO PRODUCT-DATA

           CALL "PRODUCT" USING "CREATE" PRODUCT-DATA ACTUAL-RESULT

           IF ACTUAL-RESULT CONTAINS "status"
               ADD 1 TO PASSED
               DISPLAY "  ✓ Passed"
           ELSE
               ADD 1 TO FAILED
               DISPLAY "  ✗ Failed"
           END-IF.

       TEST-READ-PRODUCT.
           ADD 1 TO TEST-COUNT
           DISPLAY "Test 2: Read product..."

           CALL "PRODUCT" USING "READ" PRODUCT-DATA ACTUAL-RESULT

           IF ACTUAL-RESULT CONTAINS "id"
               ADD 1 TO PASSED
               DISPLAY "  ✓ Passed"
           ELSE
               ADD 1 TO FAILED
               DISPLAY "  ✗ Failed"
           END-IF.

       TEST-UPDATE-PRODUCT.
           ADD 1 TO TEST-COUNT
           DISPLAY "Test 3: Update product..."

           MOVE '{"id":1,"price":1999.99}'
               TO PRODUCT-DATA

           CALL "PRODUCT" USING "UPDATE" PRODUCT-DATA ACTUAL-RESULT

           IF ACTUAL-RESULT CONTAINS "status"
               ADD 1 TO PASSED
               DISPLAY "  ✓ Passed"
           ELSE
               ADD 1 TO FAILED
               DISPLAY "  ✗ Failed"
           END-IF.

       TEST-DELETE-PRODUCT.
           ADD 1 TO TEST-COUNT
           DISPLAY "Test 4: Delete product..."

           CALL "PRODUCT" USING "DELETE" PRODUCT-DATA ACTUAL-RESULT

           IF ACTUAL-RESULT CONTAINS "deleted"
               ADD 1 TO PASSED
               DISPLAY "  ✓ Passed"
           ELSE
               ADD 1 TO FAILED
               DISPLAY "  ✗ Failed"
           END-IF.
```

### Run Tests

```bash
# Compile and run all tests
make test

# Run unit tests only
make test-unit

# Run integration tests
make test-integration

# Run with coverage
make test-coverage
```

---

## Assertions | Afirmações

Use assertions para verificar valores esperados:

Use assertions to verify expected values:

```cobol
       IF ACTUAL-VALUE = EXPECTED-VALUE
           DISPLAY "✓ Test passed"
           ADD 1 TO PASSED
       ELSE
           DISPLAY "✗ Test failed"
           DISPLAY "  Expected: " & EXPECTED-VALUE
           DISPLAY "  Got: " & ACTUAL-VALUE
           ADD 1 TO FAILED
       END-IF
```

## Melhores Práticas | Best Practices

1. **Arrange-Act-Assert**: Organize tests with setup, execute, verify
2. **Nome descritivo**: Nome do teste deve descrever o que testa
3. **Teste um por vez**: Cada test testa uma coisa específica
4. **Independente**: Testes não devem depender um do outro
5. **Rápido**: Testes devem executar rapidamente

6. **Arrange-Act-Assert**: Organize tests with setup, execute, verify
7. **Descriptive naming**: Test name should describe what it tests
8. **Test one thing**: Each test should test one specific thing
9. **Independent**: Tests should not depend on each other
10. **Fast**: Tests should execute quickly
