FROM calvaluscalmar/tomcat-base:master

LABEL Description="This image is used to start Geoserver" Maintainer="Declan Dunne"

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -q

ARG GEOSERVER_VERSION=2.18.2
ENV GEOSERVER_URL https://downloads.sourceforge.net/project/geoserver/GeoServer/${GEOSERVER_VERSION}/geoserver-${GEOSERVER_VERSION}-war.zip

# Prepare GeoServer
RUN set -x \
    && curl -fSL "$GEOSERVER_URL" -o /geoserver.war.zip \
    && unzip /geoserver.war.zip -d /geoserver_tmp \
    && mkdir /geoserver \
    && cd /geoserver \
    && jar xvf ../geoserver_tmp/geoserver.war \
    && rm -rf /geoserver_tmp \
    && rm -rf /geoserver.war.zip

ADD config /config

ADD run.sh /
RUN chmod a+x /run.sh
CMD ["/run.sh"]
