#!/bin/bash
 
PASSWD=/etc/passwd 
AA=/dev/null
BB=------------------------------------

Menu() {
cat << EOF
(관리 목록)
------------------------------------
1) 사용자 추가
2) 사용자 확인
3) 사용자 삭제
4) 종료
------------------------------------
EOF
}
UserAdd() {
    echo -n "추가할 사용자 이름은? : "
    read UNAME1
    cat $PASSWD | awk '{print $1}' | grep -w $UNAME1 > $AA 2>&1
    if [ $? -eq 0 ] ; then
        echo "$BB"
        echo "사용자가 존재합니다."
        echo "$BB"
    else
        useradd $UNAME1 >$AA 2>&1
        echo $UNAME1 | passwd --stdin $UNAME1 >$AA 2>&1
        echo "사용자가 추가되었습니다."
        echo "$BB"
    fi 
}
UserVerify() {
    cat << EOF
------------------------------------
$(awk -F: '$3 >= 1000 && $3 <= 60000 {print $1}' $PASSWD | cat -n)
------------------------------------

EOF
}
UserDel() {
    echo -n "삭제할 사용자 이름? : "
    read UNAME2

    cat /etc/passwd | awk -F: '{print $1}' | grep -w $UNAME2 >$AA 2>&1
    if [ $? -eq 0 ] ; then
        userdel -r $UNAME2
        echo "$BB"
        echo "사용자가 삭제되었습니다."
        echo "$BB"
    else
        echo "$BB"
        echo "사용자가 없습니다."
        echo "$BB"
    fi
}

while true
do
    Menu
    echo -n "선택 번호?(1|2|3|4) : "
    read NUM

    case $NUM in
        1) UserAdd ;;
        2) UserVerify ;;
        3) UserDel ;;
        4) break ;;
        *) echo "[WARN] 잘못된 선택을 했습니다." ; echo
    esac
    echo 
done 