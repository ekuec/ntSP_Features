#! /bin/bash

HOME_DIR=$PWD
DATA_DIR="/home/ekuec/Projects/reference/alpha_fold/yeast/pdb"
input=$1

cd $DATA_DIR

while IFS= read -r var; do  
  if [ -e *$var* ]; then 
    cp *$var* $HOME_DIR/
  else
   echo "MISSING $var!"
  fi
done < "$HOME_DIR/$input"

# THIS IS BAD PRACTICE
cd $HOME_DIR
