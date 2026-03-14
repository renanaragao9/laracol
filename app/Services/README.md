# Services | Serviços

📋 **Português BR:** Services são programas COBOL que encapsulam lógica de negócio reutilizável. Eles promovem separação de responsabilidades e facilitam testes unitários.

📋 **English:** Services are COBOL programs that encapsulate reusable business logic. They promote separation of concerns and facilitate unit testing.

---

## Português BR - Guia de Uso

### O que é um Service?

Um Service é um programa COBOL que contém lógica de negócio específica da aplicação. Diferente de Models (que trabalham com dados do BD), Services implementam processos mais complexos.

### Exemplo de Criar um Service

Para criar um novo service chamado `EmailService.cbl`:

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EMAILSERVICE.

      *> Comentário: Service para envio de emails
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 EMAIL-RECIPIENT PIC X(100).
       01 EMAIL-SUBJECT PIC X(200).
       01 EMAIL-BODY PIC X(1000).
       01 SMTP-SERVER PIC X(50) VALUE "smtp.gmail.com".
       01 SMTP-PORT PIC 9(4) VALUE 587.
       01 IS-SENT PIC X VALUE 'N'.

       LINKAGE SECTION.
       01 RECIPIENT PIC X(100).
       01 SUBJECT PIC X(200).
       01 BODY PIC X(1000).
       01 RESULT PIC X(100).

       PROCEDURE DIVISION USING RECIPIENT SUBJECT BODY RESULT.

      *> Comentário: Prepara email para envio
           MOVE RECIPIENT TO EMAIL-RECIPIENT
           MOVE SUBJECT TO EMAIL-SUBJECT
           MOVE BODY TO EMAIL-BODY

      *> Comentário: Valida destinatário
           IF EMAIL-RECIPIENT = SPACES
               MOVE '{"status":"erro","message":"Email inválido"}'
                   TO RESULT
           ELSE
               PERFORM SEND-EMAIL
               MOVE '{"status":"sucesso","message":"Email enviado"}'
                   TO RESULT
           END-IF

           GOBACK.

       SEND-EMAIL.
           DISPLAY "Enviando email para: " & EMAIL-RECIPIENT
           DISPLAY "Assunto: " & EMAIL-SUBJECT
           MOVE 'Y' TO IS-SENT.
```

### Exemplos de Services Comuns

1. **EmailService**: Envio de emails
2. **PaymentService**: Processamento de pagamentos
3. **FileService**: Gerenciamento de arquivos
4. **AuthService**: Autenticação e autorização
5. **ValidationService**: Validação de dados complexa
6. **ReportService**: Geração de relatórios

### Estrutura Recomendada

```
Services/
├── EmailService.cbl
├── PaymentService.cbl
├── FileService.cbl
├── AuthService.cbl
├── ValidationService.cbl
└── README.md (este arquivo)
```

### Padrão de Chamada

```cobol
CALL "EMAILSERVICE" USING RECIPIENT SUBJECT BODY RESULT

CALL "PAYMENTSERVICE" USING AMOUNT PAYMENT-METHOD RESULT

CALL "AUTHSERVICE" USING USERNAME PASSWORD RESULT
```

---

## English - Usage Guide

### What is a Service?

A Service is a COBOL program that contains application-specific business logic. Unlike Models (which work with database data), Services implement more complex processes.

### Example of Creating a Service

To create a new service called `PaymentService.cbl`:

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PAYMENTSERVICE.

      *> Comment in English: Service for payment processing
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 PAYMENT-AMOUNT PIC 9(9)V99.
       01 PAYMENT-METHOD PIC X(20).
       01 PAYMENT-STATUS PIC X(20) VALUE "pending".
       01 TRANSACTION-ID PIC 9(10).
       01 PAYMENT-GATEWAY-URL PIC X(100) VALUE
           "https://api.payment.com".

       LINKAGE SECTION.
       01 AMOUNT PIC 9(9)V99.
       01 METHOD PIC X(20).
       01 RESULT PIC X(200).

       PROCEDURE DIVISION USING AMOUNT METHOD RESULT.

      *> Comment: Validates payment details
           MOVE AMOUNT TO PAYMENT-AMOUNT
           MOVE METHOD TO PAYMENT-METHOD

      *> Comment: Process payment
           IF PAYMENT-AMOUNT <= 0
               MOVE '{"status":"error","message":"Invalid amount"}'
                   TO RESULT
           ELSE
               PERFORM PROCESS-PAYMENT
               MOVE '{"status":"success","transaction_id":"' &
                   FUNCTION TRIM(TRANSACTION-ID) & '"}'
                   TO RESULT
           END-IF

           GOBACK.

       PROCESS-PAYMENT.
           DISPLAY "Processing payment of " & PAYMENT-AMOUNT
           DISPLAY "Method: " & PAYMENT-METHOD
           MOVE FUNCTION RANDOM TO TRANSACTION-ID.
```

### Examples of Common Services

1. **EmailService**: Email sending
2. **PaymentService**: Payment processing
3. **FileService**: File management
4. **AuthService**: Authentication and authorization
5. **ValidationService**: Complex data validation
6. **ReportService**: Report generation

### Recommended Structure

```
Services/
├── EmailService.cbl
├── PaymentService.cbl
├── FileService.cbl
├── AuthService.cbl
├── ValidationService.cbl
└── README.md (this file)
```

### Calling Pattern

```cobol
CALL "EMAILSERVICE" USING RECIPIENT SUBJECT BODY RESULT

CALL "PAYMENTSERVICE" USING AMOUNT PAYMENT-METHOD RESULT

CALL "AUTHSERVICE" USING USERNAME PASSWORD RESULT
```

---

## Melhores Práticas | Best Practices

1. **Responsabilidade Única**: Cada service deve fazer uma coisa bem
2. **Reutilização**: Services devem ser reutilizáveis por múltiplos controllers
3. **Testes**: Services devem ser fáceis de testar
4. **Documentação**: Sempre documente os parâmetros de entrada e saída

5. **Single Responsibility**: Each service should do one thing well
6. **Reusability**: Services should be reusable by multiple controllers
7. **Testing**: Services should be easy to test
8. **Documentation**: Always document input and output parameters
