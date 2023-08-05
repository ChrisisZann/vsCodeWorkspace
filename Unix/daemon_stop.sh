#!/bin/sh

# Utils
# DATETIME=$(date +'%Y%m%d_%H%M%S')

# Setup Directories
export LIB_DIR="./lib"

# TODO 
# Get latest directories

# export LOG_DIR="./log/$DATETIME"
# export WORK_DIR="./work/$DATETIME"

# Daemon to kill
export BNAME="daemon_template"

# Setup Filenames 
export LOG_FILE="$LOG_DIR/${BNAME}_${DATETIME}_$$.log"
export PID_FILE="$WORK_DIR/$BNAME.pid"

# Include Libs
source "$LIB_DIR/print_lib.sh"
source "$LIB_DIR/pid_lib.sh"
source "$LIB_DIR/work_lib.sh"


{
    # delete_pid_file 
}