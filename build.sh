#!/bin/bash

while getopts i:f: flag
do
    case "${flag}" in
        i) ignore_requirement=${OPTARG};;
        f) feature=${OPTARG};;
    esac
done

header_function(){
    echo """  
-------------------------------------------------------------
Lambda function AWS build.  

Flags: 
    \033[0;31m-f\033[0m [feature] Use this flag to skip filling steps. 
    \033[0;31m-i\033[0m [y]       Use this flag when not is nescessary 
                 download packages of the python.      
-------------------------------------------------------------
                                               By: _5R3U5T0N_
    """
}

#Get feature name
if [$feature = ""]; then
    header_function
    echo -n 'Feature build: '
    read feature
fi

#Feature directory
FETAURE_DIR="lib/features/$feature"

no_requirement_function(){
    #Directory build
    SAM_BUILD_DIR="$FETAURE_DIR/.aws-sam/build"
    
    #Go to directory
    cd $SAM_BUILD_DIR

    #List directory and replace files e path only
    for dir in $(ls -d */); 
    do
       cd $dir
       cp -r ../../../src/* .
       cp ../../../../../settings.py lib/settings.py
       cp -r ../../../../../core lib/
       cp -r ../../../../../cross lib/
       cp -r ../../../../../storage lib/
       cd ../
    done
    echo '\033[1;32mBuild Successfully...\033[0m'    
}

#Check exist folder
if [ -d "$FETAURE_DIR" ]; then

#Check exist no requeriments
if [ $ignore_requirement = "y" ]; then
  no_requirement_function
  exit
fi

#Go to directory
cd $FETAURE_DIR

#Create new path temp
rm -rf .aws-sam-temp
mkdir .aws-sam-temp

#Copy files project to path temp
cp -r src .aws-sam-temp
cp template.yml .aws-sam-temp

#Run build in path .temp
cd .aws-sam-temp

#Create path lib
mkdir -p src/lib

#Copy files configuration
cp ../../../settings.py src/lib/settings.py
cp -r ../../../core src/lib/core
cp -r ../../../cross src/lib/cross
cp -r ../../../storage src/lib/storage
cp ../../../../requirements.txt src

#Sam build
sam build

#Sam build result to origin 
rm -rf ../.aws-sam
cp -r .aws-sam ../.aws-sam
cd ../

#Remove path temp
rm -rf .aws-sam-temp

fi

#sam deploy --guided --profile dev