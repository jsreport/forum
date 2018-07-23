#!/bin/bash
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker build -t forum .
docker tag forum jsreport/forum:$TRAVIS_TAG
docker push jsreport/forum

git clone https://github.com/pofider/kubernetes.git
cd kubernetes
chmod +x push.sh
./push.sh "forum" "jsreport/forum"