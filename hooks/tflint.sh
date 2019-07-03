#!/bin/bash

set -e

# OSX GUI apps do not pick up environment variables the same way as Terminal apps and there are no easy solutions,
# especially as Apple changes the GUI app behavior every release (see https://stackoverflow.com/q/135688/483528). As a
# workaround to allow GitHub Desktop to work, add this (hopefully harmless) setting here.
export PATH=$PATH:/usr/local/bin
docker run --rm -v $(pwd):/data -t wata727/tflint

if [[ "$OSTYPE" == "linux-gnu" ]]; then
        # ...
        TF_DIRS=$(find . -type f -name '*.tf' | sed -r 's|/[^/]+$||' |sort -u)
        for d in $TF_DIRS; do
          echo $d;
          docker run --rm -v $(pwd):/data -t wata727/tflint;
        done

elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
        TF_DIRS=$(find . -type f -name '*.tf' | sed -E 's|/[^/]+$||' |sort -u)
        for d in $TF_DIRS; do
          echo $d;
          docker run --rm -v $(pwd):/data -t wata727/tflint;
        done
# elif [[ "$OSTYPE" == "cygwin" ]]; then
#         # POSIX compatibility layer and Linux environment emulation for Windows
# elif [[ "$OSTYPE" == "msys" ]]; then
#         # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
# elif [[ "$OSTYPE" == "win32" ]]; then
#         # I'm not sure this can happen.
# elif [[ "$OSTYPE" == "freebsd"* ]]; then
#         # ...
# else
#         # Unknown.
fi




# for file in "$@"; do
#   terraform fmt `dirname $file`
# done
