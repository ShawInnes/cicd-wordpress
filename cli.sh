#!/bin/sh

docker run -it --rm \
    --volumes-from wp-main \
    --network container:wp-main \
    wordpress:cli /bin/sh
