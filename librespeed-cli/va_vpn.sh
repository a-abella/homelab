#!/bin/sh

docker run --rm --net container:gluetun ghcr.io/danieletorelli/librespeed-cli:latest librespeed-cli --server 78
