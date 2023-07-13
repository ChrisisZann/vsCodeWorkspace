#include <stdio.h>
#include <stdlib.h>
#include <libpq-fe.h>

int main() {
    // Create a connection object
    PGconn *conn = PQconnectdb("dbname=mydatabase user=myuser password=mypassword");

    // Check if the connection was successful
    if (PQstatus(conn) != CONNECTION_OK) {
        fprintf(stderr, "Connection to database failed: %s", PQerrorMessage(conn));
        PQfinish(conn);
        return 1;
    }

    // Execute a query
    PGresult *res = PQexec(conn, "SELECT * FROM mytable");

    // Check if the query execution was successful
    if (PQresultStatus(res) != PGRES_TUPLES_OK) {
        fprintf(stderr, "Query execution failed: %s", PQerrorMessage(conn));
        PQclear(res);
        PQfinish(conn);
        return 1;
    }

    // Get the number of rows and columns returned by the query
    int num_rows = PQntuples(res);
    int num_cols = PQnfields(res);

    // Iterate over the rows and columns to fetch the results
    for (int row = 0; row < num_rows; row++) {
        for (int col = 0; col < num_cols; col++) {
            printf("%s\t", PQgetvalue(res, row, col));
        }
        printf("\n");
    }

    // Clear the result and close the connection
    PQclear(res);
    PQfinish(conn);

    return 0;
}
