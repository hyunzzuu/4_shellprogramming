#!/bin/bash

echo -n "what is file name? : "
read FILE1
  : << EOF
# echo $FILE1

if [ -x $FILE1 ] ; then 
  eval $FILE1
fi 
EOF

[ -x $FILE1 ] && eval $FILE1 