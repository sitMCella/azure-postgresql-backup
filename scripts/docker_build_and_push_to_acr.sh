#!/bin/bash

# Prerequisite:
# chmod +x docker_build_and_push_to_acr.sh
#
# Execute:
# docker_build_and_push_to_acr.sh <subscription_id> <docker_image_name> <docker_image_tag> <container_registry_name> <dockerfile_path> <dockerfile_context>

SUBSCRIPTION_ID="$1"
IMAGE_NAME="$2"
IMAGE_TAG="$3"
REGISTRY_NAME="$4"
DOCKERFILE_PATH="$5"
DOCKERFILE_CONTEXT="$6"

az account set --subscription $SUBSCRIPTION_ID

az acr build -t $IMAGE_NAME:$IMAGE_TAG -r $REGISTRY_NAME -f $DOCKERFILE_PATH $DOCKERFILE_CONTEXT
