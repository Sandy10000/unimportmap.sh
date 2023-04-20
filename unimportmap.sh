#!/usr/bin/bash

THREEROOT=$1

directoryjsm=$THREEROOT/examples/jsm
declare -i depth=0
regexp1=\'three\'
replacement1=build/three.module.min.js\'
regexp2=\'three/nodes\'
replacement2=nodes/Nodes.js\'

function processDirectory(){
	for child in `ls $1`;do checkFile $1/$child;done
	depth=$depth-1
}

function checkFile(){
	if [ -f $1 ];then processFile $1
	else checkDirectory $1
	fi
}

function checkDirectory(){
	if [ -d $1 ];then
		depth=$depth+1
		processDirectory $1
	fi
}

function processFile(){
	jsm=\'
	for i in `seq 1 $depth`;do jsm+=../;done
	root=$jsm../../
	sed -i -e s@$regexp1@$root$replacement1@ -e s@$regexp2@$jsm$replacement2@ $1
}

cp $THREEROOT/package.json $directoryjsm
processDirectory $directoryjsm