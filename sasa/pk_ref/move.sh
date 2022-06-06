#! /bin/bash

HOME_DIR=$PWD
DATA_DIR="bak"
input=$1

while IFS= read -r var; do  
  if [ -e *$var* ]; then 
    mv *$var* $DATA_DIR/
  else
   echo "MISSING $var!"
  fi
done < "$input"

