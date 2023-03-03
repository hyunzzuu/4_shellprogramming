#!/bin/bash
# # userdel $UNAME
FILE1=/root/bin/user.list
cat $FILE1 | while read UNAME UPASS
do
    userdel -r $UNAME
    echo $UPASS | passwd --stdin $UNAME > /dev/null 2>&1
    echo "[ OK ] $UNAME"
done