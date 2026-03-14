# Public | Público

📋 **Português BR:** Diretório público da aplicação. Contém arquivos CGI e assets que são servidos diretamente ao cliente.

📋 **English:** Public directory of the application. Contains CGI files and assets that are served directly to the client.

---

## Português BR - Arquivo CGI

### O que é o index.cgi?

O `index.cgi` é o arquivo CGI (Common Gateway Interface) que funciona como ligação entre o servidor web (Apache, Nginx) e a aplicação COBOL.

### Exemplo de index.cgi

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. INDEXCGI.

      *> Comentário: CGI router principal
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 REQUEST-METHOD PIC X(10).
       01 REQUEST-PATH PIC X(500).
       01 QUERY-STRING PIC X(500).
       01 REQUEST-BODY PIC X(5000).
       01 RESPONSE-DATA PIC X(5000).

       PROCEDURE DIVISION.

      *> Comentário: Obtém variáveis de ambiente CGI
           ACCEPT REQUEST-METHOD FROM ENVIRONMENT "REQUEST_METHOD"
           ACCEPT REQUEST-PATH FROM ENVIRONMENT "REQUEST_URI"
           ACCEPT QUERY-STRING FROM ENVIRONMENT "QUERY_STRING"
           ACCEPT REQUEST-BODY FROM CONSOLE

      *> Comentário: Define header HTTP
           DISPLAY "Content-Type: application/json"
           DISPLAY "Access-Control-Allow-Origin: *"
           DISPLAY "Access-Control-Allow-Methods: GET, POST, PUT, DELETE"
           DISPLAY " "

      *> Comentário: Roteia requisição
           EVALUATE REQUEST-METHOD
               WHEN "GET"
                   PERFORM HANDLE-GET-REQUEST
               WHEN "POST"
                   PERFORM HANDLE-POST-REQUEST
               WHEN "PUT"
                   PERFORM HANDLE-PUT-REQUEST
               WHEN "DELETE"
                   PERFORM HANDLE-DELETE-REQUEST
               WHEN OTHER
                   MOVE '{"error":"Método não suportado"}'
                       TO RESPONSE-DATA
           END-EVALUATE

           DISPLAY RESPONSE-DATA
           GOBACK.

       HANDLE-GET-REQUEST.
      *> Comentário: Trata requisições GET
           MOVE '{"method":"GET","path":"' & FUNCTION TRIM(REQUEST-PATH) & '"}'
               TO RESPONSE-DATA.

       HANDLE-POST-REQUEST.
      *> Comentário: Trata requisições POST
           MOVE '{"method":"POST","path":"' & FUNCTION TRIM(REQUEST-PATH) & '"}'
               TO RESPONSE-DATA.

       HANDLE-PUT-REQUEST.
      *> Comentário: Trata requisições PUT
           MOVE '{"method":"PUT","path":"' & FUNCTION TRIM(REQUEST-PATH) & '"}'
               TO RESPONSE-DATA.

       HANDLE-DELETE-REQUEST.
      *> Comentário: Trata requisições DELETE
           MOVE '{"method":"DELETE","path":"' & FUNCTION TRIM(REQUEST-PATH) & '"}'
               TO RESPONSE-DATA.
```

### Variáveis de Ambiente CGI

| Variável           | Descrição             | Exemplo                |
| ------------------ | --------------------- | ---------------------- |
| REQUEST_METHOD     | Método HTTP           | GET, POST, PUT, DELETE |
| REQUEST_URI        | Caminho da requisição | /api/users             |
| QUERY_STRING       | Query parameters      | id=1&name=joao         |
| CONTENT_LENGTH     | Tamanho do corpo      | 256                    |
| CONTENT_TYPE       | Tipo de conteúdo      | application/json       |
| HTTP_HOST          | Host da requisição    | localhost:8080         |
| HTTP_AUTHORIZATION | Token de autenticação | Bearer token123        |

---

## English - CGI File

### What is index.cgi?

The `index.cgi` is the CGI (Common Gateway Interface) file that acts as the link between the web server (Apache, Nginx) and the COBOL application.

### Example of index.cgi

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. INDEXCGI.

      *> Comment: Main CGI router
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 REQUEST-METHOD PIC X(10).
       01 REQUEST-PATH PIC X(500).
       01 QUERY-STRING PIC X(500).
       01 REQUEST-BODY PIC X(5000).
       01 RESPONSE-DATA PIC X(5000).

       PROCEDURE DIVISION.

      *> Comment: Get CGI environment variables
           ACCEPT REQUEST-METHOD FROM ENVIRONMENT "REQUEST_METHOD"
           ACCEPT REQUEST-PATH FROM ENVIRONMENT "REQUEST_URI"
           ACCEPT QUERY-STRING FROM ENVIRONMENT "QUERY_STRING"
           ACCEPT REQUEST-BODY FROM CONSOLE

      *> Comment: Set HTTP headers
           DISPLAY "Content-Type: application/json"
           DISPLAY "Access-Control-Allow-Origin: *"
           DISPLAY "Access-Control-Allow-Methods: GET, POST, PUT, DELETE"
           DISPLAY " "

      *> Comment: Route request
           EVALUATE REQUEST-METHOD
               WHEN "GET"
                   PERFORM HANDLE-GET-REQUEST
               WHEN "POST"
                   PERFORM HANDLE-POST-REQUEST
               WHEN "PUT"
                   PERFORM HANDLE-PUT-REQUEST
               WHEN "DELETE"
                   PERFORM HANDLE-DELETE-REQUEST
               WHEN OTHER
                   MOVE '{"error":"Method not supported"}'
                       TO RESPONSE-DATA
           END-EVALUATE

           DISPLAY RESPONSE-DATA
           GOBACK.

       HANDLE-GET-REQUEST.
      *> Comment: Handle GET requests
           MOVE '{"method":"GET","path":"' & FUNCTION TRIM(REQUEST-PATH) & '"}'
               TO RESPONSE-DATA.

       HANDLE-POST-REQUEST.
      *> Comment: Handle POST requests
           MOVE '{"method":"POST","path":"' & FUNCTION TRIM(REQUEST-PATH) & '"}'
               TO RESPONSE-DATA.

       HANDLE-PUT-REQUEST.
      *> Comment: Handle PUT requests
           MOVE '{"method":"PUT","path":"' & FUNCTION TRIM(REQUEST-PATH) & '"}'
               TO RESPONSE-DATA.

       HANDLE-DELETE-REQUEST.
      *> Comment: Handle DELETE requests
           MOVE '{"method":"DELETE","path":"' & FUNCTION TRIM(REQUEST-PATH) & '"}'
               TO RESPONSE-DATA.
```

### CGI Environment Variables

| Variable           | Description      | Example                |
| ------------------ | ---------------- | ---------------------- |
| REQUEST_METHOD     | HTTP method      | GET, POST, PUT, DELETE |
| REQUEST_URI        | Request path     | /api/users             |
| QUERY_STRING       | Query parameters | id=1&name=john         |
| CONTENT_LENGTH     | Body size        | 256                    |
| CONTENT_TYPE       | Content type     | application/json       |
| HTTP_HOST          | Request host     | localhost:8080         |
| HTTP_AUTHORIZATION | Auth token       | Bearer token123        |

---

## Estrutura do Diretório | Directory Structure

```
public/
├── index.cgi        - Arquivo CGI principal
├── .htaccess        - Configuração Apache (se aplicável)
└── README.md        - Este arquivo
```

## Configuração do Servidor Web | Web Server Configuration

### Apache (.htaccess)

```apache
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteRule ^(.*)$ index.cgi/$1 [QSA,L]
</IfModule>
```

### Nginx (nginx.conf)

```nginx
location / {
    try_files $uri $uri/ /index.cgi?$query_string;
}

location ~ \.cgi$ {
    fastcgi_pass 127.0.0.1:9000;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    include fastcgi_params;
}
```

---

## Headers HTTP Padrão | Standard HTTP Headers

```
Content-Type: application/json  Tipo de resposta
Access-Control-Allow-Origin: *  CORS permitido
Cache-Control: no-cache         Sem cache
X-Content-Type-Options: nosniff Security header
```
