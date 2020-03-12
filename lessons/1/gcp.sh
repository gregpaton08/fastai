#!/usr/bin/env bash

##########
#
# Script for creating and connecting to a Google Cloud Platform instance.
#
##########

# Notes
#
# To view instances:
#   gcloud compute instances list
#

set -e

export IMAGE_FAMILY="pytorch-latest-gpu" # or "pytorch-latest-cpu" for non-GPU instances
# export ZONE="us-west1-b"
# export ZONE="us-west2-b"
# export ZONE="us-central1-a"
export ZONE="us-central1-c"
# export ZONE="us-east1-b"
# export INSTANCE_NAME="my-fastai-instance-budget"
export INSTANCE_NAME="my-fastai-instance-budget-$ZONE"
# export INSTANCE_TYPE="n1-highmem-8"
# budget:
export INSTANCE_TYPE="n1-highmem-4"

function usage {
    echo "usage: $0 [connect|create]"
    echo "  connect     connect to the gcp instance"
    echo "  create      create the gcp instance"
    exit 1
}

function create_gcp_instance {
    echo "creating google cloud platform instance..."
    # --accelerator="type=nvidia-tesla-p100,count=1" \
    # budget:
    # --accelerator="type=nvidia-tesla-k80,count=1" \
    # to make preemptible add:
    # --preemptible
    gcloud compute instances create $INSTANCE_NAME \
            --zone=$ZONE \
            --image-family=$IMAGE_FAMILY \
            --image-project=deeplearning-platform-release \
            --maintenance-policy=TERMINATE \
            --accelerator="type=nvidia-tesla-k80,count=1" \
            --machine-type=$INSTANCE_TYPE \
            --boot-disk-size=200GB \
            --metadata="install-nvidia-driver=True"
}

function connect_to_gcp_instance {
    echo "connecting to google cloud platform instance..."
    gcloud compute ssh jupyter@$INSTANCE_NAME -- -L 8080:localhost:8080
    # gcloud compute ssh --zone=$ZONE jupyter@$INSTANCE_NAME -- -L 8080:localhost:8080
}

function start_gcp_instance {
    echo "starting google cloud platform instance..."
    gcloud compute instances start $INSTANCE_NAME
}

function stop_gcp_instance {
    echo "stopping google cloud platform instance..."
    gcloud compute instances stop $INSTANCE_NAME
}

function set_action {
    if [ ! -z $action ]; then
        echo "invalid arguments"
        usage
    fi
    action=$1
}

for i in "$@"
do
case $i in
    connect)
    set_action connect_to_gcp_instance
    shift
    ;;
    create)
    set_action create_gcp_instance
    shift
    ;;
    start)
    set_action start_gcp_instance
    shift
    ;;
    stop)
    set_action stop_gcp_instance
    shift
    ;;
    *)
    echo "invalid arguments"
    usage
esac
done

if [ -z $action ]; then
    echo "invalid arguments"
    usage
fi

$action
