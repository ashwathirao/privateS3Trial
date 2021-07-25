#!/usr/bin/env bash

timestamp(){
    date
}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $DIR
touch .env
echo "REACT_APP_HOST_URL=https://8080-${GITPOD_WORKSPACE_URL#*//}" > .env
echo "$(timestamp) Starting guru-shifu..."
docker-compose -f docker-compose-gitpod.yml up -d
if [ $? == 0 ]
then
  echo "$(timestamp) Waiting for guru-shifu to start up.... "
  until $(curl --output /dev/null --silent --head --fail http://localhost:3000/); do
    printf "."
    sleep 1
  done
  echo "$(timestamp) Guru-shifu started successfully..."
fi
cd /workspace
