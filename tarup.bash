#!/bin/bash

WANKI=$(pwd)

pushd ~/.local/share
tar -zcvf Anki.tar.gz Anki && mv Anki.tar.gz ${WANKI}
tar -zcvf Anki2.tar.gz Anki2 && mv Anki2.tar.gz ${WANKI}
popd
