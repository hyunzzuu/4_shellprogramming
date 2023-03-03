#!/bin/bash

echo -n "what is file name? : "
read FILE1 

if [ -f $FILE1 ] ; then
  echo "file"
elif [ -d $FILE1 ] ; then 
  echo "dfile"
else
  echo "No"
fi 