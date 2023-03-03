#!/bin/bash

echo -n "your choice? (yes/no)"
read CHOICE 

case $CHOICE in
    yes|Y|YES|y|Yes) echo "[ OK ] YES~~~";;
    no|N|NO|n|No) echo"[ FAIL ] NO~~";;
    *) echo "[FAIL] yes or no"
        exit 1;;
esac 