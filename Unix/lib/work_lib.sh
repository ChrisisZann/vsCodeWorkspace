#!/bin/zsh

init_work()
{
    if [[ ! -d "$WORK_DIR" ]];
    then 
        mkdir "$WORK_DIR"
    fi
}
