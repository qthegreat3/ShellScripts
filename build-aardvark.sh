#!/bin/bash

function build {
	echo "Building $(echo "$1" | awk -F'/' '{ print $NF }')"
	cd $1
	STATUS=$(mvn clean install -U | grep "BUILD SUCCESS\|BUILD FAILURE")
	if [[ "$STATUS" = *"BUILD SUCCESS"* ]]; then
		echo "Build successful"
	        SUCCESS=$((SUCCESS+1))
	else
		echo "Build unsuccessful"
	        FAILURE=$((FAILURE+1))
	fi
}

SUCCESS=0
FAILURE=0

if [ -e aardvark.build ]; then
	while read p; do
		pathName=$(echo $p | awk '{ print $1 }')	
		path=$(echo $p | awk '{ print $2 }')
		if [ "$pathName" == "aardvarkPath" ]; then
			aardvarkPath=$path
		fi
		if [ "$pathName" == "asaePath" ]; then
			asaePath=$path
		fi
	done <aardvark.build
else
	echo "Path to aardvark projects? (/path/to/project)"
	read aardvarkPath
	touch aardvark.build
	echo "aardvarkPath $aardvarkPath" >> aardvark.build
	echo "Path to asae projects? (/path/to/project)"
	read asaePath
	echo "asaePath $asaePath" >> aardvark.build
fi


build $aardvarkPath/aardvark-poms
build $aardvarkPath/aardvark-base
build $aardvarkPath/aardvark-apps
build $asaePath/asae-base
build $asaePath/asae-apps
build $asaePath/asae-apps/packaging


echo "Successes: $SUCCESS , Failures: $FAILURE"
