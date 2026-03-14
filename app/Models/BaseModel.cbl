       IDENTIFICATION DIVISION.
       PROGRAM-ID. BASEMODEL.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 DB-COMMAND PIC X(500).
       01 SQL-STMT PIC X(500).
       01 DATABASE-PATH PIC X(100) VALUE 
           "database/app.db".

       LINKAGE SECTION.
       01 ACTION PIC X(20).
       01 DATA-INPUT PIC X(500).
       01 RESULT-OUTPUT PIC X(500).

       PROCEDURE DIVISION USING ACTION DATA-INPUT RESULT-OUTPUT.

           EVALUATE ACTION
               WHEN "INSERT"
                   MOVE DATA-INPUT TO RESULT-OUTPUT
               WHEN "UPDATE"
                   MOVE DATA-INPUT TO RESULT-OUTPUT
               WHEN "DELETE"
                   MOVE '{"status":"deleted"}' TO RESULT-OUTPUT
               WHEN "SELECT"
                   MOVE '{"data":"[]"}' TO RESULT-OUTPUT
               WHEN OTHER
                   MOVE '{"error":"Invalid action"}' TO RESULT-OUTPUT
           END-EVALUATE

           GOBACK.
