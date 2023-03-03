#!/bin/bash
Usage() {
    echo "Usage"
}


echo -n "Enter numver 1 : "
read NUM1 

echo -n "Enter numver 2 : "
read NUM2

cat << EOF
==============================================
 (1). +    (2). -    (3). *    (4). /
==============================================
EOF

echo -n "Enter your choice? (1|2|3|4) : "
read OP

case $OP in
    1) echo "$NUM1 + $NUM2 = expr $NUM1 + $NUM2" ;;
    2) echo "$NUM1 - $NUM2 = expr $NUM1 - $NMU2" ;;
    3) echo "$NUM1 \* $NUM2 = expr $NUM1 \* $NUM2" ;;
    4) echo "$NUM1 / $ NUM2 = expr $NUM1 / $NUM2" ;;
    *) echo "[ FAIL ] 계산할수 없음." ; exit 1;;
esac