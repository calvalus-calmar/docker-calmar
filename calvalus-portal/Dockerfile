FROM calvaluscalmar/tomcat-base:master

LABEL Description="This image is used to start the Calvalus portal" Maintainer="Declan Dunne"

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -q

COPY --from=calvaluscalmar/calvalus-base:master /build/usr/share/java/calvalus/calvalus-portal/calvalus-portal.war /

# extract calvalus-portal war file amd move to webapps
RUN set -x \
    && mkdir /calvalus-portal \
    && cd /calvalus-portal \
    && jar xf /calvalus-portal.war \
    && rm /calvalus-portal.war

ADD config /config

ADD run.sh /
RUN chmod a+x /run.sh
CMD ["/run.sh"]
