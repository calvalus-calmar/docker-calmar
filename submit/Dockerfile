# This script is based on https://github.com/big-data-europe/docker-hadoop
FROM calvaluscalmar/hadoop-base:master

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -q

COPY WordCount.jar /opt/hadoop/applications/WordCount.jar

ENV JAR_FILEPATH="/opt/hadoop/applications/WordCount.jar"
ENV CLASS_TO_RUN="WordCount"
ENV PARAMS="/input /output"

ADD run.sh /run.sh
RUN chmod a+x /run.sh

CMD ["/run.sh"]
