#!/bin/bash


echo  -e "Please encure that you have jdk zip file in the directory and \n should be named as jdk-8u181-linux-x64.tar.gz"
read -p "Enter maven home: " mvnhome
read -p "Enter JDK home: " jdkhome

# Build docker images.
parentimage="parent-spring:latest"
childimage="guru-datta:1.0"

result=$(docker image build -t "$parentimage" .)
result=$(docker image build -t "$childimage" --file Dockerfile-guru-datta .)

docker image ls -a | grep "parent-spring" >/dev/null
status1=$?
docker image ls -a | grep "guru-datta" >/dev/null
status2=$?
if [ "$status1" -a "$status2" ]
then 
    echo "Images successfully built"
    docker image ls -a | grep -E  "guru-datta|parent-spring"
fi

echo "Building the cotnainer:"
read -p "Enter the port number on localhost (ex: 9001 ): " port
read -p "Enter a unique container name : " cont

#Remove all containers that match name
$(docker container run -d -p $port:8080 --name $cont guru-datta:1.0)
docker container ls -a | grep "$cont"
status=$?
if [ $status -eq 0 ] ; then 
    echo "container running successfully on http://localhost:$port"
    sleep 3
    curl http://localhost:$port
fi 
