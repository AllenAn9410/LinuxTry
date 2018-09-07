#!bin/bash

function list(){
    cat ./oldFile/list.txt | while read line
    do
        echo ${line#*/}
        echo ${line##*/}
    done

}


echo "pls put mv old verson into oldFile folder "
echo "eeps"
if [ -d "dest" ]; then
    rm -rf dest/
fi
# scp -r eeps@10.39.104.40:/home/devci/jenkins/workspace/ESUN_313/dest/ .
list

