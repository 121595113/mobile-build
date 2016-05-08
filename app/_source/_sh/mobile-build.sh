#! /bin/bash  
shName=`basename $0 .sh`
cd ../../
configDir=_source/_config
configName="${shName}.rb"

if [ x$1 != x ] && [ $1 == '-p' ]
then
	echo "生产模式，全压缩"
	compass compile -c $configDir/$configName -e development --force
	compass compile -c $configDir/$configName -e production --force
else
	echo "开发模式，带有sourcemap"
	compass watch -c $configDir/$configName

fi
