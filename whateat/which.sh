#!/bin/bash
eat_file="./eat"
choose_file="./this"

echo "random you lunch:" > $choose_file
a=(`awk '{print $0}' $eat_file`)
rand=$[ $RANDOM % ${#a[@]} ]
rand_eat=${a[$rand]} 
echo $rand_eat >> $choose_file
echo "ok..."
