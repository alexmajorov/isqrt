#!/bin/bash

opts="O2 O0"
size=2000000000
step=1000000
repeat=1000000

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

for opt in $opts; do
    gcc -std=c99 -Wall -Werror -Wpedantic -Wextra -DTESTS="${size}" -DSTEP="${step}" -DREPEAT="${repeat}" -"${opt}" -D_POSIX_C_SOURCE=199309L \
    main.c -o ./apps/app_"${size}"_"${opt}".exe -lm
done
