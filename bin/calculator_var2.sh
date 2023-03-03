#!/bin/bash
for i in $(seq 3)
do
    echo -n "Enter A : "
    read A1
    echo -n "Enter Operator : "
    read OP
    echo -n "Enter C : "
    read C1

    case $OP in
        '+') echo "$A1 + $C1 = $(expr $A1 + $C1)" ;;
        '-') echo "$A1 - $C1 = $(expr $A1 - $C1)" ;;
        '*') echo "$A1 * $C1 = $(expr $A1 \* $C1)" ;;
        '/') echo "$A1 / $C1 = $(expr $A1 / $C1)" ;;
        *) echo "ERROR"
        exit 1
    esac
done