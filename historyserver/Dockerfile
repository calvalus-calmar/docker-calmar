# This script is based on https://github.com/big-data-europe/docker-hadoop
FROM calvaluscalmar/hadoop-base:master

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -q

HEALTHCHECK CMD curl -f http://localhost:19888/ || exit 1

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 19888

CMD ["/run.sh"]
