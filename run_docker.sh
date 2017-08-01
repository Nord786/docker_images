#!/usr/bin/env bash

image=${1:-pytorch_murashev}
name=${2:-$image}

echo $image
echo $name

nvidia-docker run --net=host \
                  --ipc=host \
                    -it \
                    -v "/home/a.murashev/SSD":/WORK \
                    -v "/mnt/disk1/":/mnt/disk1 \
                    -v "/mnt/ssd1/":/mnt/ssd1 \
                    -v "/mnt/ssd2/":/mnt/ssd2 \
                    --name $name \
                    $image \
                    bash
