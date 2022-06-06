#! /bin/bash

WRK_DIR=`pwd`

for i in *.pdb; do
  x=${i%-F1*}
  y=${x##*AF-}
  echo -n $y   
  echo -ne '\t'
  cp $i file.pdb
  python sasa.py 
  rm -f file.pdb
done
