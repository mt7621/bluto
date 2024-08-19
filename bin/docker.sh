#!/bin/bash

AWSuserID=$(aws sts get-caller-identity --query "Account" --output text)
aws ecr get-login-password --region ap-northeast-2 | sudo docker login --username AWS --password-stdin $AWSuserID.dkr.ecr.ap-northeast-2.amazonaws.com

cd ./employee
sudo docker build -t employee ./

sudo docker tag employee:latest $AWSuserID.dkr.ecr.ap-northeast-2.amazonaws.com/employee:latest
sudo docker push $AWSuserID.dkr.ecr.ap-northeast-2.amazonaws.com/employee:latest


cd ../token
sudo docker build -t token ./

sudo docker tag token:latest $AWSuserID.dkr.ecr.ap-northeast-2.amazonaws.com/token:latest
sudo docker push $AWSuserID.dkr.ecr.ap-northeast-2.amazonaws.com/token:latest
