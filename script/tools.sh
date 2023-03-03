#!/bin/bash

cat << EOF
====================================================
  (1). who      (2). date     (3). pwd              
====================================================

EOF

echo -n "choice? (1|2|3):"
read CHOICE

case $CHOICE in 
    1) who ;;
    2) date ;;
    3) pwd ;;
    *) echo "[ FAIL ] Choice error"
esac 