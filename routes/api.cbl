       IDENTIFICATION DIVISION.
       PROGRAM-ID. APIROUTER.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 REQ-METHOD PIC X(10).
       01 REQ-PATH   PIC X(200).
       01 VERSION PIC X(5) VALUE "v1.0".

       PROCEDURE DIVISION.

           ACCEPT REQ-METHOD FROM ENVIRONMENT "REQUEST_METHOD"
           ACCEPT REQ-PATH FROM ENVIRONMENT "PATH_INFO"

           PERFORM DISPATCH-REQUEST

           GOBACK.

       DISPATCH-REQUEST.
           EVALUATE TRUE
               WHEN REQ-METHOD = "GET" AND REQ-PATH = "/api/health"
                   PERFORM RESPONSE-HEALTH

               WHEN REQ-METHOD = "GET" AND REQ-PATH = "/api/welcome"
                   CALL "WELCOMECONTROLLER"
               WHEN REQ-METHOD = "GET" AND REQ-PATH = "/"
                   CALL "WELCOMECONTROLLER"

               WHEN OTHER
                   PERFORM RESPONSE-NOT-FOUND
           END-EVALUATE.

       RESPONSE-HEALTH.
           DISPLAY "Content-Type: application/json"
           DISPLAY " "
           DISPLAY '{"status":"healthy","version":"'
               VERSION '","framework":"Laracol"}'
           .

       RESPONSE-NOT-FOUND.
           DISPLAY "Content-Type: application/json"
           DISPLAY " "
           DISPLAY '{"error":"Not Found","status":404,'
               '"message":"Endpoint não encontrado"}'
           .
