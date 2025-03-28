#!/bin/bash

SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PROJECT_ROOT=${SCRIPT_PATH}/../../

IMAGE_NAME="matter-ubuntu"
IMAGE_TAG="22.04"

if [ $# -eq 0 ]; then
    echo "No arguments provided. Running container without additional arguments."
    CMD="bash"
else
    CMD="$@"
fi

if docker image inspect "$IMAGE_NAME:$IMAGE_TAG" > /dev/null 2>&1; then
    echo "Docker image $IMAGE_NAME:$IMAGE_TAG already exists. Running container..."
else
    echo "Docker image $IMAGE_NAME:$IMAGE_TAG does not exist. Building image..."
    docker build -t "$IMAGE_NAME:$IMAGE_TAG" -f "$SCRIPT_PATH/Dockerfile" "$PROJECT_ROOT"
fi

echo "Running Docker container with command: $CMD"
docker run -i --rm \
  -v "$PROJECT_ROOT:/workspace" \
  "$IMAGE_NAME:$IMAGE_TAG" \
  $CMD
