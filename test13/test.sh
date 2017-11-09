#!/bin/bash

function start(){
  if [ !-n $input ];then
    echo "Now that you hesitate, that's it yes"
    input="yes"
  fi
}
function validate(){
  while [ "${input}" != "yes" ]&&[ "${input}" != "no" ];do
    start
  done

}


echo "do you love me [yes or yes]"
read -t 10 input
start
validate