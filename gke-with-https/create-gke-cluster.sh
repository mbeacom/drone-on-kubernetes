#!/usr/bin/env bash
gcloud components update
gcloud container clusters create drone \
    --machine-type n1-standard-1 --num-nodes 1
if [ $? -eq 1 ]
then
    echo "Unable to create GKE cluster. Aborting."
    exit 1
fi
./create-disk.sh
gcloud container clusters get-credentials drone
