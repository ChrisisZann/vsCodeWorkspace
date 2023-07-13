#include "program_one.h"

void print_message(char* message, char* severity);

int main(int argc, char *argv[])
{
    print_message("Test mesage", "INFO");


    return 0;
}

void print_message(char* message, char* severity){
    time_t currentTime;
    time(&currentTime);
    
    char* timestamp = ctime(&currentTime);
    printf("========================================================\n");
    printf("Timestamp: %s", timestamp);
    printf("Severity: %s\n", severity);
    printf("Message: %s\n", message);
    printf("========================================================\n");
}   