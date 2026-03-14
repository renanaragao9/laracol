       IDENTIFICATION DIVISION.
       PROGRAM-ID. WELCOMECONTROLLER.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 RESPONSE-DATA PIC X(300).

       PROCEDURE DIVISION.

           DISPLAY "Content-Type: application/json"
           DISPLAY " "
           
           MOVE '{"message":"Bem-vindo ao Laracol",'
               & '"framework":"Laravel-like em COBOL",'
               & '"docs":"https://laracol.dev"}'
               TO RESPONSE-DATA
           DISPLAY RESPONSE-DATA

           GOBACK.
