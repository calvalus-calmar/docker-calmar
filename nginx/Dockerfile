# This script is based on https://github.com/big-data-europe/docker-hadoop
FROM nginx

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -q

COPY default.conf /etc/nginx/conf.d/default.conf
COPY materialize.min.css /data/bde-css/materialize.min.css
COPY bde-hadoop.css /data/bde-css/bde-hadoop.css
