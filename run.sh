#!/bin/bash

docker run -it --rm -v $(pwd)/:/models/lib -v /a/nad.previz/x/x__style_transfer_darkat__2010251156/:/models/darkat jgwill/ai-tf2 bash

