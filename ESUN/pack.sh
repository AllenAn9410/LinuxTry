#!bin/bash

function list(){
    cat ./oldFile/list.txt | while read line
    do
        if [[ ${line} =~ "/src/" ]];then
           Ajar ${line}
            continue
        elif [[ ${line} =~ "/WebContent/" ]];then
            echo "js ${line}"
            continue
        elif [[ ${line} =~ "jar" ]];then
            echo "jar ${line}"
            continue
        fi
    done
}

function Ajar(){
    str=${1//src/}
    pName=${str[0]}
    jName=${str[1]%.*}
    echo ${pName}
}

echo "pls put mv old verson into oldFile folder "
echo "eeps"
if [ -d "dest" ]; then
    rm -rf dest/
fi
# scp -r eeps@10.39.104.40:/home/devci/jenkins/workspace/ESUN_313/dest/ .
list

