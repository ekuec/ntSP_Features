#! /bin/bash

WRK_DIR=`pwd`
DAT_DIR="/home/ekuec/Projects/reference/alpha_fold/yeast/pdb"

cd $DAT_DIR
for i in *.pdb; do
  echo -ne $i'\t'
  $WRK_DIR/contact_order.pl $i
done
