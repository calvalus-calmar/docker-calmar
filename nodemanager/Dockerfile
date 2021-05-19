# This script is based on https://github.com/big-data-europe/docker-hadoop
FROM calvaluscalmar/hadoop-base:master

# install libproj (required to support minimum GDAL)
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -q \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      libproj19 \
    && rm -rf /var/lib/apt/lists/*

# install GDAL to Native Hadoop Library directory
COPY --from=calvaluscalmar/calvalus-base:master /build/usr/lib/libgdalalljni.so /opt/hadoop-$HADOOP_VERSION/lib/native/
COPY --from=calvaluscalmar/calvalus-base:master /build/usr/lib/libgdal.so /opt/hadoop-$HADOOP_VERSION/lib/native/

HEALTHCHECK CMD curl -f http://localhost:8042/ || exit 1

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8042

CMD ["/run.sh"]
