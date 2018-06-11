#!/bin/bash

#allen.an
#function : copy and compress
#
currentPath=`pwd`
currentFolder=${PWD##*/}
sourcePath="/home/eeadmin/base/devci/jenkins/workspace/esp_develop/com.cs.esphome"
mfvr=${currentPath}/data/EE_PARA/mfvr/
echo $currentFolder
echo $mfvr

if [ ! -d "$mfvr" ];then
  echo "can not find ${mfvr} path"
  mkdir $mfvr
fi

if [  ! -d "${sourcePath}" ];then
  echo  "can not find ${sourcePath} path"
  exit
fi

function copyFromSource(){
  # echo "update mfvr : ${sourcePath} --> ${mfvr}"
  mkdir ${currentPath}/ESP
  targetFolder=${currentPath}/ESP
  rsync -av ${sourcePath}/home ${targetFolder}
  rsync -av ${sourcePath}/lib ${targetFolder}
  mkdir ${targetFolder}/sql
  rsync -av ${sourcePath}/sql/esp_oracle.sql ${targetFolder}/sql 
  echo "copy is ok"

  rm -drf ${targetFolder}/home/bolero
  rm -drf ${targetFolder}/home/cert
  rm -drf ${targetFolder}/home/wsdl
  rm -r ${targetFolder}/home/logs
  mkdir ${targetFolder}/home/logs
  mv ${targetFolder}/home ${targetFolder}/mfvr
  meta=${targetFolder}/mfvr/meta
  rm -rf ${meta}/*
  mkdir ${meta}/SYSM_BATP_DEF ${meta}/SYSM_GAPI_PTCL ${meta}/SYSM_BATG_DEF ${meta}/SYSM_GAPI_LSTN ${meta}/SYSM_MATCH_TMPL
  
  rsync -av ${targetFolder}/lib/cs/war/ESP.war ${targetFolder}/

  mkdir ${targetFolder}/ESP_LIB
  rsync -av ${sourcePath}/lib/*.jar ${targetFolder}/ESP_LIB
  rsync -av ${sourcePath}/lib/cs/*.jar ${targetFolder}/ESP_LIB
  rsync -av ${sourcePath}/lib/j2ee/com.ibm.mq*.jar ${targetFolder}/ESP_LIB

  rm -drf ${targetFolder}/lib
}

function update_mfvr(){
  rsync -av --delete ${targetFolder}/mfvr/ ${mfvr}
}
function compress_mfvr(){
  echo "package"
  cd ${currentPath}
  tar -zcvf ESP.jar.gz ESP
  rm -drf ${currentPath}/ESP
}
copyFromSource
# update_mfvr
compress_mfvr

