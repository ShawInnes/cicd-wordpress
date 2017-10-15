#!/bin/sh

docker run -it --rm \
    --volumes-from wp-admin \
    --network container:wp-admin \
    wordpress:cli /bin/sh
