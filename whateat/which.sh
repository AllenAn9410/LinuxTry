#!/bin/bash
  eat_file="./eat"
  choose_file="./this"
  show_file="./show"
  echo "random you lunch:" > $choose_file
  echo "Computer recommendation:" >$show_file
  function main(){
    a=(`awk '{print $0}' $eat_file`)
    rand=$[ $RANDOM % ${#a[@]} ]
    rand_eat=${a[$rand]} 
    echo $rand_eat >> $choose_file 
  }
  temp1=0
  function check(){
    
    if [ $times -gt $temp1 ];then
      num1=${a[i]}
      temp1=$times
    fi
  }
  for i in $(seq 1 100)
  do 
    main
  done
  
  #cat $choose_file
  ii=$[${#a[@]}-1]
  for i in $(seq 0 $ii )
  do
    times=`grep -o ${a[i]} $choose_file | wc -l`
    #echo $times ${a[i]}
    
  check
  done
  echo "ok..."
  echo $num1 >> $show_file
  cat $show_file
  sleep 5
  
