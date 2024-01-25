#!/bin/bash
set -eu

# shellcheck disable=SC2034
sapujagad2_DIR=./
# shellcheck source=/mnt/docker/prepare.sh
source ./docker/prepare.sh sapujagad2_DIR

docker build \
  --tag "${DOCKER_IMAGE_NAME_PREFIX}/sapujagad2-util:${image_tag}" \
  --build-arg "jdk_image=${JDK_8_IMAGE}" \
  --file ./docker/util/Dockerfile \
  ./docker/util
