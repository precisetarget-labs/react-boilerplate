#!/usr/bin/env bash

# Helper script to test docker builds locally (i.e.: mimic CI setups, etc.)

# Quit on first error
set -e

# Inject env variables from .env
ENV_FILENAME=.env

if [ ! -f "$ENV_FILENAME" ]; then
  echo "Required file '$ENV_FILENAME' not found!"
  exit -1
else
  while IFS="=" read -r name value; do
    export "$name=$value"
  done < "$ENV_FILENAME"
fi

# Figure out image name
IMAGE_NAME=

if [ -z "$1" ]; then
  echo "Required argument for image name not provided!"
  exit -2
else
  IMAGE_NAME=$1
fi

# Build and test app
yarn install
npm run build

# Build the docker image
docker build -f Dockerfile -t "$IMAGE_NAME:test" .

# To run the image, use:
# docker run --name "$IMAGE_NAME-test" -p 5432:80 "$IMAGE_NAME:test"
