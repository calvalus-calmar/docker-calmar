FROM tomcat:9.0-jdk8-openjdk

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -q

LABEL Description="This image is used to reconfigure the default tomcat directory structure" \
      Maintainer="Declan Dunne"

CMD ["/run.sh"]
