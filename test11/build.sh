#!/bin/bash
function get_input(){
  printf "\n -----${BLUE}EE Docker test${NC} ----- \nbegin prepare your docker env.[default value is the first item]\n"
  read -p "Project id:" proj_id
  if [ -z $proj_id ] ; then 
    exit 0 
  fi
  if [ $proj_id -lt 2000 ] || [ $proj_id -gt 4999 ] ; then 
    echo "error id : ${proj_id},please check your regist info!"
    exit
  fi
  s_port=$(( $proj_id * 10 ))

  read -p "Project name:" proj_name
  if [ -z $proj_name ] ; then
    exit 0 
  fi
  lists=(none ora_test1 ora_test2 ora_test3)
  read -p "database type :(1-ora_test1, 2-ora_test2, 3-ora_test3 : )   " i
  if [ -z $i ] ; then
    i=1 
  fi 
  db_type=${lists[i]}
  lists=(none mq_test1 mq_test2 )
  read -p "mq : (1-mq_test1 , 2-mq_test2 )   " i 
  if [ -z $i ]; then
    i=1
  fi
  mq_type=${lists[i]}

  lists=(none was_test1 was_test2 was_test3)
  read -p "ap/web server:(1-was_test1 , 2-was_test2 , 3-was_test3 : )   " i
  if [ -z $i ]; then
    i=1
  fi 
  ap_type=${lists[i]}

  if [ -z proj_id ] || [ -z proj_name ]; then 
    echo "id and name cannot null!"
    exit
  fi
}

function apweb_ee() {
  echo "create folder: $proj_name"
  if [ ! -d "${proj_name}/data/EE_PARA" ]; then
    mkdir -p ${proj_name}/data/EE_PARA
    mkdir -p ${proj_name}/data/EE_Y
  fi

  let web_port=$s_port+0
  let admin_port=$s_port+1
  let debug_port-$s_port+7
     
  case "${ap_type}" in
    was_test1)
      echo "was_test1";;
    was_test2)
      echo "was_test2";;
    was_test3)
      echo "was_test3";;
  esac
 }

function db_ee() {
  let db_port=$s_port+2
  case "${db_type}" in
    ora_test1)
      echo "ora_test1";;
    ora_test2)
      echo "ora_test2";;
    ora_test3)
      echo "ora_test3";;
  esac
 }

# ---main---
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'
COMMON=${pwd}

if [ "$1" == "clean" ] ; then
  echo "clean folder"
  exit
fi

input_ok="no"

while [ "$input_ok" == "no" ] ; do
  get_input 
  printf "\n\nproj:${RED}${proj_id}${NC}\n"
  printf " DB:${RED}$db_type${NC} AP:${RED}$ap_type${NC} MQ:${RED}${mq_type}${NC}\n\n"
  read -p "are you sure?[yes,no,quit]" input_ok
  while [ "${input_ok}" != "yes" ] && [ "${input_ok}" != "no" ] && [ "${input_ok}" != "quit" ] ; do
    read -p "are you sure?[yes,no,quit]" input_ok
  done
done

if [ !${input_ok} == "yes" ]; then 
  exit 1
fi

if [ -f ${proj_name}/docker-compse.yml ]; then
  mkdir -p ${proj_name}/data 
  cp ${COMMON}/dc_00.yml ${proj_name}/docker-compse.yml
  cp ${COMMON}/README.md ${proj_name}/README.md
fi

apweb_ee
db_ee

