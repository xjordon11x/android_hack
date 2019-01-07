#!/bin/bash


if [ $# -lt 1 ];then
	echo "Need to give input for app name"
	exit
fi

paths=`adb shell pm list packages |grep $1|awk -F ":" '{print $2}'`
i=0;
declare -a apps



for x in $paths
do 
	apps[$i]=$x
	echo "[$i] - $x"
	i=$(($i + 1))
done

if [ $i -lt 1 ]; then
	echo "No Packages Found"
	exit
fi

app_name=0

if [ $i -gt 1 ];then
	echo "Which one would you like to get --> use number?" 
	read app_name
fi	

ap=${apps[$app_name]}
echo "Pulling "+$ap
ap2=`echo $ap| sed 's/\\r//g'`
#echo $ap2
app_path=`adb shell pm path $ap2 |cut -d':' -f2`
#echo $app_path
app_path2=`echo $app_path |sed 's/\\r//g'`
new_dir=`echo $ap2 | cut -d "/" -f4`
mkdir $new_dir
pull_path=$(pwd)/$ap2
#echo $pull_path
adb pull $app_path2 $pull_path
#ls -lrt $new_dir
echo "App Pulled from device"
sleep 2
echo "APKTOOL Decompiling"

cd $pull_path
apktool d base.apk



