#!/bin/bash
reasons=(
    'aaaaa'
    'bbbbb'
    'cccccc'
)

rand=$[ $RANDOM % ${#reasons[@]} ]
rand_reason=${reasons[$rand]} 
echo $rand_reason
echo ${#reasons[@]}