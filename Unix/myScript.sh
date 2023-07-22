#!/bin/zsh

# Utils
DATETIME=$(date +'%Y%m%d_%H%M%S')

# Setup Directories
export LIB_DIR="."
export LOG_DIR="./log/$DATETIME"
export WORK_DIR="./work"
export BNAME=$(basename -s ".sh" $0)

# Setup Filenames 
export LOGFILE="$LOG_DIR/${BNAME}_${DATETIME}_$$.log"
export PIDFILE="$WORK_DIR/$BNAME.pid"

# Include Libs
. $LIB_DIR/myLib_Sh

# Create pid file
echo $$ > $PIDFILE

# Print parameters
print_par basename $BNAME
print_par "PID File" $PIDFILE
print_par LOG_DIR $LOG_DIR  
print_par LOGFILE $LOGFILE

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

if [ -n $LOG_DIR ];
then 
    mkdir $LOG_DIR
fi

{ #Log Start

    print_log INFO "PID=$$"

    read_input

    while [ -f $PIDFILE ]; do
        print_log_message INFO "Process ID is $$"
        sleep 30
        echo $(date +"The Process [$$] says: The current date and time is %F %T")
    done

    print_log_message INFO "Process Ended" 

} >> $LOGFILE 2>&1

