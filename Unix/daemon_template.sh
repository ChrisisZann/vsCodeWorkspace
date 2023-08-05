#!/bin/sh

# Utils
DATETIME=$(date +'%Y%m%d_%H%M%S')

# Setup Directories
export LIB_DIR="./lib"
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
   
    echo "[OPTIND=$OPTIND]"
    echo "[OPTARG=$OPTARG]"
    
    case "${opt_flag}" in
        s)
            echo "flag -s is set"
            ;;
        p)
            echo "flag -p is set"
            echo "argument : ${OPTARG}"
            ;;
        *)
            usage
            ;;
    esac
    done
}

daemon_loop()
{
    while [ -f $PID_FILE ]; do
        print_log_message INFO "Process is still running"
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
    print_log_message INFO "PID=$$"
    read_input

    # Signal Handling
    trap 'delete_pid_file;' INT

    daemon_loop

    # Exit daemon
    print_log_message INFO "Process Ended" 

} >> "$LOG_FILE" 2>&1

# ========================================================