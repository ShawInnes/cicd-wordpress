#!/bin/sh

docker run -it --rm \
    --volumes-from wp-admin \
    --network container:wp-admin \
    wordpress:cli wp core install --url="http://admin.wordpress.dev" --title="Admin Wordpress" --admin_user=admin --admin_email=admin@wordpress.dev --admin_password="wordpress" --skip-email

docker run -it --rm \
    --volumes-from wp-admin \
    --network container:wp-admin \
    wordpress:cli wp plugin install mainwp --activate

docker run -it --rm \
    --volumes-from wp-admin \
    --network container:wp-admin \
    wordpress:cli wp plugin uninstall akismet hello

### Main Site
docker run -it --rm \
    --volumes-from wp-main \
    --network container:wp-main \
    wordpress:cli wp core install --url="http://main.wordpress.dev" --title="Main Wordpress" --admin_user=admin --admin_email=admin@wordpress.dev --admin_password="wordpress" --skip-email

docker run -it --rm \
    --volumes-from wp-main \
    --network container:wp-main \
    wordpress:cli wp plugin install mainwp-child mailchimp-for-wp contact-form-7 --activate

docker run -it --rm \
    --volumes-from wp-main \
    --network container:wp-main \
    wordpress:cli wp plugin uninstall akismet hello

docker run -it --rm \
    --volumes-from wp-main \
    -v `pwd`/themes:/tmp/themes \
    --network container:wp-main \
    wordpress:cli wp theme install /tmp/themes/corpboot.zip /tmp/themes/corpboot-child-theme.zip

docker run -it --rm \
    --volumes-from wp-main \
    --network container:wp-main \
    wordpress:cli wp theme activate corpboot

docker run -it --rm \
    --volumes-from wp-child \
    --network container:wp-child \
    wordpress:cli wp core install --url="http://child.wordpress.dev" --title="Child Wordpress" --admin_user=admin --admin_email=admin@wordpress.dev --admin_password="wordpress" --skip-email

docker run -it --rm \
    --volumes-from wp-child \
    --network container:wp-child \
    wordpress:cli wp plugin install mainwp-child mailchimp-for-wp contact-form-7 --activate

docker run -it --rm \
    --volumes-from wp-child \
    --network container:wp-child \
    wordpress:cli wp plugin uninstall akismet hello

docker run -it --rm \
    --volumes-from wp-child \
    -v `pwd`/themes:/tmp/themes \
    --network container:wp-child \
    wordpress:cli wp theme install /tmp/themes/corpboot.zip /tmp/themes/corpboot-child-theme.zip

docker run -it --rm \
    --volumes-from wp-child \
    --network container:wp-child \
    wordpress:cli wp theme activate corpboot
