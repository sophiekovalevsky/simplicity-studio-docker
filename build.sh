#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: "
    echo "  ${0} <Dockerfile>"
fi

DOCKERFILE=${1:-Dockerfile}
# Remove uppercase letters. Replace : by _
DOCKER_IMAGE_NAME=`echo $(basename $PWD) | tr [:upper:] [:lower:] | tr '/:' '_'`
# Lets use the docker image name for the moment
DOCKER_IMAGE_TAG=${DOCKER_IMAGE_NAME}

docker build --rm --tag ${DOCKER_IMAGE_TAG} \
             --file $PWD/${DOCKERFILE} .


echo "---> Docker image built successfully"
echo

docker images | grep "$DOCKER_IMAGE_TAG"
