#! /bin/bash
# allen.an

updateFileName="./updateFile"
logDateTime=$(date +%Y%m%d-%H%M%S)
dateName=$(date +%Y%m%d)

function checkFile(){
    if [ ! -d "${updateFileName}" ];then
        mkdir ${updateFileName}
        logs "new file updateFile "
    fi
    mkdirCurrentDateFile
}
function mkdirCurrentDateFile(){
    if [ ! -d "${updateFileName}/${dateName}" ];then
        mkdir ${updateFileName}/${dateName}
        logs "new file ${dateName} and put update files in it "
    fi
    mkdirLogs
}
function mkdirLogs(){
    if [ ! -x "${updateFileName}/${dateName}/${dateName}.log" ];then
        touch "${updateFileName}/${dateName}/${dateName}.log"
    fi
    if [ ! -d "${updateFileName}/${dateName}/backup" ];then
        mkdir "${updateFileName}/${dateName}/backup"
    fi
}
function logs(){
    echo "${logDateTime}  $1 "
}

function backup(){
    # $1 date
    # $2 jar
    # $3 class
    # com/cs/core/rest/RestClientAPI.class
    logs "Decompress ${2} and backup to folder ${updateFileName}/${1}/backup" > "${updateFileName}/${1}/${1}.log"
    jar -xvf ${updateFileName}/$1/${2} -f ${3}
    mv "com" ${updateFileName}/${1}/backup/${2}
}

checkFile
backup "20180816" CSEECore.jar "com/cs/core/rest/RestClientAPI.class"
