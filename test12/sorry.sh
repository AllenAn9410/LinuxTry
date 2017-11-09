#!/bin/bash
#
#by allen.an
#

function start(){
  read -p "I am so sorry to say that,can you listen to my explanation ?(yes or no):" your_response
}

function verify_response(){
  while  [ "$your_response" != "yes" ]; do
    if [ ! -n "$your_response" ]; then
      echo "Come on ,your should input yes or no and i hope you can input yes"
      start
    fi 
    if [ "$your_response" == "no" ]; then
      echo "As you wish, I just hope you'll forgive me"
      exit
    else
      echo "Your should input yes or no and i hope you can input yes"
      start
    fi
  done
  explan   
}

function explan(){
    echo "Take a joke,i can not find object"
}


#
#main
#
start
verify_response