#!/bin/bash

DOCKER_IMAGE_NAME=`echo $(basename $PWD) | tr [:upper:] [:lower:] | tr '/:' '_'`
SIMPLICITY_STUDIO_DIR=simplicity-studio
CONTAINER_NAME=DOCKER_IMAGE_NAME
USER_NAME=engineer

# Get absolute path of the directory containig this script
MAIN_DIR=$(cd "$(dirname "$0")"; pwd)

# Launch Simplicity Studio
docker run --rm --privileged \
	--env DISPLAY=unix$DISPLAY \
	--name $CONTAINER_NAME \
	--volume /dev/bus/usb:/dev/bus/usb \
	--volume /tmp/.X11-unix:/tmp/.X11-unix \
	--volume "${MAIN_DIR}/${SIMPLICITY_STUDIO_DIR}:/opt/${SIMPLICITY_STUDIO_DIR}" \
	--volume "${MAIN_DIR}/workspace:/home/${USER_NAME}/${SIMPLICITY_STUDIO_DIR}/v4_workspace" \
	--volume "${MAIN_DIR}/shared:/home/${USER_NAME}/shared" \
	$DOCKER_IMAGE_NAME
