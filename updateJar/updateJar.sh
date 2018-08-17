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
    logs "BK ${1} ${2} --> ${updateFileName}/${dateName}/backup" >> "${updateFileName}/${dateName}/${dateName}.log"
    jar -xvf ${updateFileName}/${dateName}/${1} -f ${2}
    # rsync
    cp -r "com" ${updateFileName}/${dateName}/backup/${1}
    rm -rf "com"
}

checkFile
backup CSEECore.jar "com/cs/core/rest/RestClientAPI.class"
