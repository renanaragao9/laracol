       IDENTIFICATION DIVISION.
       PROGRAM-ID. HTTPKERNEL.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 HTTP-METHOD PIC X(10).
       01 HTTP-PATH   PIC X(100).

       PROCEDURE DIVISION.

           ACCEPT HTTP-METHOD FROM ENVIRONMENT "REQUEST_METHOD"
           ACCEPT HTTP-PATH FROM ENVIRONMENT "PATH_INFO"

           PERFORM ROUTE-REQUEST

           GOBACK.

       ROUTE-REQUEST.
           DISPLAY "Content-Type: application/json"
           DISPLAY " "
           DISPLAY '{"message":"Kernel placeholder"}'
           GOBACK.
