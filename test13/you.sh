#!/bin/bash
#
#author allen.an
#this shell just to exercise linux command
#
#
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

function start(){
  echo $(pwd) is current path
  today=`date +%Y-%m-%d`
  echo "today is ${today}"
  OLD_IFS="$IFS"
  IFS="-"
  arrays=($today)
  IFS="$OLD_IFS"
  todayYear=${arrays[0]}
  todayMonth=${arrays[1]}
  TodayDay=${arrays[2]}
  #echo ${todayYear} ${todayMonth} ${TodayDay}
  #read -p "what about your weight ?if you think it's secert, you can don't say it.Just enter:" weight
#echo $name $birth_date $height $weight
}

function input_name(){
  read -p "first of all,your name:" name
  validate_name
}

function validate_name(){
  if [ ! -n "$name" ];then
    echo "you shoud tell me your name"
    input_name
  fi
}

function input_birth_date(){
 read -p "hello,${name}.I'd like to know the exact date of your birth date(1994-01-01):" birth_date  
 validate_birth_date
}

function validate_birth_date(){
  if [ ! -n "$birth_date" ];then
    printf "\n${RED}come on $name,don't be shy.${NC}\n"
    printf "\n${RED}I'd like to know the exact date of your birth date(1994-01-01)${NC}\n"
    input_birth_date
  fi
  OLD_IFS="$IFS"
  IFS="-"
  array=($birth_date)
  IFS="$OLD_IFS"
  year=${array[0]}
  month=${array[1]}
  day=${array[2]}
  #echo "year:${year} month:${month} day:${day}"
  
  if [ ! -n "${year}" ] ;then 
    printf "\n${RED}Wrong date format of yera${NC}\n"
    input_birth_date
  fi
  if [ ! -n "${month}" ];then 
   printf "\n${RED}Wrong date format of month${NC}\n"
    input_birth_date
  fi
  if [ ! -n "${day}" ];then 
    printf "\n${RED}Wrong date format of day${NC}\n"
    input_birth_date
  fi

  if [[ ! ${year} =~ ^[0-9] ]];then
    printf "\n${RED}you should input number in date of year${NC}\n"
    input_birth_date
  fi
  if [[ ! ${month} =~ ^[0-9] ]];then
    printf "\n${RED}you should input number in date of month${NC}\n"
    input_birth_date
  fi
  if [[ ! ${day} =~ ^[0-9] ]];then
    printf "\n${RED}you should input number in date of day${NC}\n"
    input_birth_date
  fi
  age=`expr $todayYear - $year`
  twelveMonth=12
  numberOfDays=31
  if [ ${year} -gt ${todayYear} ];then
    printf "\n${RED}are you Alien?you age is ${age}${NC}\n "
    input_birth_date
  fi
  if [ ${month} -gt ${twelveMonth} ];then
    printf "\n${RED}a year just have twelve month${NC}\n"
    input_birth_date
  fi
  
  r1=`expr ${year} % 4`
  r2=`expr ${year} % 100`
  r3=`expr ${year} % 400`
  if [ $r1 -eq 0 -a $r2 -ne 0 -o $r3 -eq 0 ];then
    FRUN="true"
  else
    FRUN="false"
  fi
  #echo $FRUN

  case "$month" in 
    01|03|05|07|08|10|12) 
      days=31 ;;
    04|06|09|11) 
      days=30 ;;
    02)
      if [ "$FRUN" = "true" ];then 
        days=29 
      else 
        days=28 
      fi 
      ;;
    *)
      printf "\n${RED}a year just have twelve month,and you should add 0 when month before September(08)${NC}\n"  
      input_birth_date
      ;;
  esac 
  #echo "days:${days}"
  if [ ${days} -lt ${day} ];then
    printf "\n${RED}There are ${days} days in ${month} ${year}${NC}\n"
    input_birth_date
  fi
}

function validate_Constellation(){
#this code just a shit
#  if [ $month -ge 1 ] && [ $day -ge 20] && [ $month -le 2 ] && [ $day -ge 18 ];then
#    echo "Aquarius    "
#  elif [ $month -ge 2 ] && [ $day -ge 19] && [ $month -le 3 ] && [ $day -ge 20 ];then
#    echo "Pisces     "
#  elif [ $month -ge 3 ] && [ $day -ge 21] && [ $month -le 4 ] && [ $day -ge 19 ];then
#    echo "Aries      "
#  elif [ $month -ge 4 ] && [ $day -ge 20] && [ $month -le 5 ] && [ $day -ge 20 ];then
#    echo "Taurus    "
#  elif [ $month -ge 5 ] && [ $day -ge 21] && [ $month -le 6 ] && [ $day -ge 21 ];then
#    echo "Gemini   "
#  elif [ $month -ge 6 ] && [ $day -ge 22] && [ $month -le 7 ] && [ $day -ge 22 ];then
#    echo "Cancer   "
#  elif [ $month -ge 7 ] && [ $day -ge 23] && [ $month -le 8 ] && [ $day -ge 22 ];then
#    echo "Leo    "
#  elif [ $month -ge 8 ] && [ $day -ge 23] && [ $month -le 9 ] && [ $day -ge 22 ];then
#    echo "Virgo   "
#  elif [ $month -ge 9 ] && [ $day -ge 23] && [ $month -le 10 ] && [ $day -ge 22 ];then
#    echo "Libra    "
#  elif [ $month -ge 10 ] && [ $day -ge 24] && [ $month -le 11 ] && [ $day -ge 22 ];then
#    echo "Scorpio   "
#  elif [ $month -ge 11 ] && [ $day -ge 23] && [ $month -le 12 ] && [ $day -ge 21 ];then
#    echo "Sagittarius "
#  else
#    echo " Capricorn "
#  fi
  arr_col="魔羯水瓶双鱼牡羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯"
  arr_day=(20 19 21 21 21 22 23 23 23 23 22 22)
  month_double=`expr ${month} \* 2 `
  arr_index=`expr ${month} - 1`
  if [ ${arr_day[${arr_index}]} -gt $day ];then
    index=`expr ${month_double} - 2`
    #echo ${arr_col:${index}:2}
    Constellation=${arr_col:${index}:2}
  else
    index=`expr ${month_double} - 0`
    #echo ${arr_col:${index}:2}
    Constellation=${arr_col:${index}:2}
  fi 
}

function input_height(){
  read -p "could you tell me your height(180cm):" height 
  validate_input_height 
}

function validate_input_height(){
  if [ ! -n $heigth ];then
    printf "\n${red} height cannot be null${nc}\n"
    input_height
  fi
  if [[ ! ${height} =~ ^[0-9] ]];then
    printf "\n${red}you should input number in date${nc}\n"
    input_height
  fi
}

function input_weight(){
  read -p "what about your weight(kg):" weight
  validate_input_weight
}

function validate_input_weight(){
  if [ ! -n $weight ];then
    printf "\n${RED}ok...,try again...${NC}\n"
    input_weight
  else 
    if [[ ! ${weight} =~ ^[0-9] ]];then
      printf "\n${RED}you should input number in date\n"
      input_weight
    else
      echo "emmmmm....."
      check
    fi
  fi
}

function check(){
  height_double=`expr $height \* $height `
  weight_double=`expr $weight \* 10000 `
  proportions=`expr $weight_double / $height_double`
  #echo $proportions
}

function output(){
  printf "let's generate you information file.\n################################\n################################\n################################\n"
  dir=$(pwd)/${name}.txt
  if [ ! -f ${dir} ];then
    touch ${dir}
  fi
  echo "========================= ${name}  information =========================" > $dir
  echo "name:${name}" >> $dir
  echo "age:${age}" >> $dir
  echo "height:${height} cm" >> $dir
  echo "weight:${weight} kg" >> $dir
  if [ $proportions -gt 22 ];then
    echo "stature suggest:you should take more exercise to keep slim" >> $dir
  elif [ $proportions -lt 20 ];then
    echo "stature suggest:you need eat more" >> $dir
  else
    echo "stature suggest:You build great" >> $dir
  fi
  echo "Constellation:${Constellation}座" >> $dir
}

#
#main
#
echo "welcome,this file only use to record you information,and generate txt file"
start
input_name
input_birth_date
validate_Constellation
input_height
input_weight
output
echo "you can open ${dir} the file in $(pwd)"
sleep 15
