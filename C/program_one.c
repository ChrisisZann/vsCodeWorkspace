#include "program_one.h"

void print_message(char* message, char* severity);

int main(int argc, char *argv[])
{
    print_message("Checking log directory", "INFO");
    
    char *log_dir="./log";
    struct stat st = {0};
    // check if directory exists and  create if necessary
    if (stat(log_dir, &st) == -1) {
        if(mkdir(log_dir, 0700) == -1){
            print_message("Log directory already exists","INFO");
        }else{
            print_message("Log directory created successfuly","INFO");
        }
    }
    print_message("Finished checking directory","INFO");

    char *log_file="test.log";
    strcat(log_dir, log_file);
    printf("log_file=%s", log_file);


    // create file
    print_message("Creating log file", "INFO");

    int log_fd = creat(log_file, O_CREAT);
    if(log_fd==-1){
        print_message("Failed to create log file","ERROR");
    }else{
        print_message("Log file created successfuly","INFO");
    }

    if(close(log_fd)==-1){
        print_message("Failed to close file","ERROR");
    }else{
        print_message("Log file closed successfuly","INFO");
    }

    return 0;
}

void print_message(char* message, char* severity){
    time_t currentTime;
    time(&currentTime);
    
    char* timestamp = ctime(&currentTime);
    // printf("========================================================\n");
    printf("Timestamp: %s", timestamp);
    printf("Severity : %s\n", severity);
    printf("Message  : %s\n", message);
    printf("========================================================\n");
}   