#!/usr/bin/env bash

image=${2:-tf12_keras_murashev}
name=${1:-$image}

echo $image
echo $name

nvidia-docker run --net=host \
                    -it \
                    -v "/home/a.murashev/SSD":/WORK \
                    -v "/mnt/disk1/":/mnt/disk1 \
                    -v "/mnt/ssd1/":/mnt/ssd1 \
                    -v "/mnt/ssd2/":/mnt/ssd2 \
                    --name $name \
                    $image \
                    bash
