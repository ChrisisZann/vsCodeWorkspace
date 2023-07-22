#!/bin/bash

usage() { echo "invalid option"; exit 1; }

while getopts "shp:" opt_flag; do
   
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
        h)
            echo "help message"
            ;;
        *)
            usage
            ;;
    esac
done

