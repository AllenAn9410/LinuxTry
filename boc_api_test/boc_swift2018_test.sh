#!/bin/bash
functions_arr=(
  "/swift/cvt.pseudo"
  "/swift/recv.pseudo"
  "/swift/mfvr.mt"
)

methods=(
  "POST"
  "POST"
  "POST"
)

function check_ip(){
  read -p "input ip : " IP
  read -p "input post : " POST
  echo "ip:${IP}  post:${POST}"
  url="${IP}:${POST}/ESP/rs"
  echo "url : ${url}"
  sleep 2
  ping=`ping -c 1 ${IP} -p ${POST} | grep loss | awk -F "," '{print $3}' | awk -F "%" '{print $1}'`
  if [ ${ping} -eq 100 ];then
    echo "${IP} server can not connect.please check whether the service is started.... "
  else
    echo "${IP} server is ok"
    echo "begin testing fuction..."
    sleep 5
  fi
}

# curl -x POST/GET/PUT/DELETE "url" -d "value"
function check_func(){
  echo "check function"
  url="10.39.103.170:9082/ESP/rs"
  for ((i=0;i<${#functions_arr[@]};i++))
  do
    function_url="http://${url}${functions_arr[${i}]}"
    # function_value="${values_arr[${i}]}"
    folder="./${function_url##*/}"
    value=`cat ${folder}/value.md`

    function_method="${methods[${i}]}"
    echo -e  " url    : ${function_url}  \n method : ${function_method} \n value  : ${value} \n\n " 
    res=`curl -X ${function_method} -d "${value}" --header "esp_token:HnFHHyCfhVS4ZrlR/bYO7LNtSF4pH4Y7Oy5h4dItcmQ=" -H "Content-Type:text/plain" "${function_url}"`
    echo -e "\033[31m ${res} \033[0m"
    echo -e "\n==========================================================================\n==========================================================================\n"
    sleep 1
  done
}

function createFolder(){
  echo "check folder"
  for func in ${functions_arr[@]}
  do
    # echo ${func}
    folderName=${func##*/}
    # echo ${folderName}
    if [ ! -d "./${folderName}" ];then
      echo " ${folderName} create success "
      mkdir ${folderName}
      touch "./${folderName}/value.md"
    else
      if [ ! -f "./${folderName}/value.md" ];then
        touch "./${folderName}/value.md"
      fi
    fi
  done
}

##
## main
##
# check_ip

createFolder
check_func