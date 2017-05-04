#!/usr/bin/env bash

set -e
set -x

rm -rf pytorch || true
git clone https://github.com/pytorch/pytorch
cat Dockerfile.append >> pytorch/Dockerfile
cd pytorch
docker build -t pytorch_murashev_new .
