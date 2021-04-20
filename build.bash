#!/bin/bash

pushd $(git rev-parse --show-toplevel)
docker build -t wonesy/wanki:latest . || exit 1

if [[ $1 == "publish" ]]; then
    docker push wonesy/wanki:latest
fi

popd
