#!/usr/bin/env bash

VERSION=0.1
REPO="jadajin"
IMAGE_NAME="emupay"
IMAGE="${REPO}/${IMAGE_NAME}"
if [ ! -z ${VERSION} ]; then
    TAG="${IMAGE}:${VERSION}"
else
    TAG="${IMAGE}:latest"
fi
# build docker image
echo "Building Image: ${TAG}"
docker build --build-arg VERSION=${VERSION} -t ${TAG}  -f Dockerfile .
if [ $? -eq 0 ]; then
    echo "Build Image ${TAG} success"
    docker tag ${TAG} "${IMAGE}:latest"
    if [ $? -eq 0 ] && [[ "$1" == "push" ]]; then
        docker push ${IMAGE}
    fi
else
    echo "Build Image ${TAG} failed"
fi