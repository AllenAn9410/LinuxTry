#!/bin/bash
eatfile="./eat"
thisfile="./this"
if [ ! -f '$thisfile' ];then
  touch this;
fi
if [ ! -f '$eatfile' ]; then
  echo "no file" 
fi
echo "random you lunch:" > $thisfile
a=(`awk '{print $0}' $eatfile`)
rand=$[ $RANDOM % ${#a[@]} ]
rand_eat=${a[$rand]} 
echo $rand_eat >> $thisfile
