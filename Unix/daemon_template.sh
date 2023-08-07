#!/bin/sh

# Utils
DATETIME=$(date +'%Y%m%d_%H%M%S')

# Setup Directories
export LIB_DIR="./lib"
export BIN_DIR="./bin"
export LOG_DIR="./log/$DATETIME"
export WORK_DIR="./work/$DATETIME"
export BNAME="$(basename -s ".sh" $0)"

# Setup Filenames 
export LOG_FILE="$LOG_DIR/${BNAME}_${DATETIME}_$$.log"
export PID_FILE="$WORK_DIR/$BNAME.pid"

# Include Libs
source "$LIB_DIR/print_lib.sh"
source "$LIB_DIR/pid_lib.sh"
source "$LIB_DIR/work_lib.sh"

# Create pid file
# echo $$ > "$PID_FILE"

#  Print parameters
# ========================================================
print_par basename "$BNAME"
print_par "PID File" "$PID_FILE"
print_par LOG_DIR "$LOG_DIR"  
print_par LOG_FILE "$LOG_FILE"

#  FUNCTIONS
# ========================================================
read_input()
{
    while getopts "sp:" opt_flag; do
    
        # echo "[OPTIND=$OPTIND]"
        # echo "[OPTARG=$OPTARG]"
        case "${opt_flag}" in
            s)
                echo "flag -s is set"
                FLAG_1=TRUE
                ;;
            p)
                echo "flag -p is set"
                export ARGUMENT_2=${OPTARG}
                echo "argument : ${OPTARG}"
                ;;
            *)
                usage
                ;;
        esac
    done

    # Mandatory arguments
    if [ -z "${FLAG_1}" ];
    then
    print_par FLAG_1 "${FLAG_1}"
        echo "FLAG_1 must be set"
        exit 1
    fi
    if [ -z "${ARGUMENT_2}" ];
    then
        echo "ARGUMENT_2 must be set"
        exit 1
    fi
}

SIGINT_handler()
{
    INPUT_PID=$$
    print_log_message "WARN" "Received SIGINT, stopping the process"
    delete_pid_file
}

daemon_loop()
{
    while [ -f $PID_FILE ]; do
        # print_log_message INFO "Process is still running"
        print_log_message INFO "Running C executable"
        ./${BIN_DIR}/inner

        sleep 10
        # echo $(date +"The Process [$$] says: The current date and time is %F %T")
    done
}

#  MAIN
# ========================================================
init_log "$LOG_DIR" "$LOG_FILE"
{ # Log Start

    # Initializations
    init_work
    create_pid_file "$$"
    read_input $*

    # Signal Handling
    trap 'SIGINT_handler;' INT

    # Compile C
    (cd ${BIN_DIR}&& make)
    print_log_divider
    
    daemon_loop

    # Exit daemon
    print_log_message INFO "Process Ended" 

} >> "$LOG_FILE" 2>&1

# ========================================================