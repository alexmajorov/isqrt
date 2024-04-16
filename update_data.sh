#!/bin/bash

opts="O2 O0"
size=2000000000
funcs="rsqrt fast_rsqrt"

while getopts "s:o:h" options; do
    case "${options}" in 
        s) 
            size=${OPTARG}
            ;;
        o) 
            opts=${OPTARG}
            ;;
        h)
            echo "-s number_of_tests"
            echo "-o optimization level(s)"
            exit
            ;;
        :)
            echo "Error: -${OPTARG} requires an argument."
            exit_abnormal
            ;;
        *)                                 
            exit_abnormal                       
            ;;
    esac
done


for f in $funcs; do
    for opt in $opts; do
        ./apps/app_"${size}"_"${opt}".exe "${f}" >> ./predata/data_"${f}"/"${opt}"_"${size}".txt
    done
done
