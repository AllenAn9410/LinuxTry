#!/bin/bash
dir="/e/work"
cd $dir
mkdir `date +%Y-%m-%d`
cd $dir/`date +%Y-%m-%d`
mkdir out
cd $dir
echo "generate `date +%Y-%m-%d` file success" >>log.txt 