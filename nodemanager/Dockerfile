# This script is based on https://github.com/big-data-europe/docker-hadoop
FROM calvaluscalmar/hadoop-base:master

# 1. Install libproj (a minimum dependency requirement for GDAL support)
#    Note: you can add optional GDAL dependencies here if required by other
#    Calvalus processors
# 2. Install Python 2.7 (required to support snap-python)
#    Note: Ububtu 20.04 installs python 3.8 by default, but snap-python does
#          not have pre-built support for Python 3.8 to-date. Therefore, we will
#          install the older Python 2.7 as there is pre-built support for this.
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -q \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      libproj15 \
      python2.7 \
      python2.7-dev \
      python-is-python2 \
    && rm -rf /var/lib/apt/lists/*

# Install numpy using pip 2.7 (numpy 2.7 is not available as an install package in Ububtu 20.04)
RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py \
    && python get-pip.py \
    && pip2 install numpy \
    && rm -f get-pip.py

# Install the GDAL library and the GDAL Java bindings to the Native Hadoop Library directory
# Note: Native GDAL is included to support the GDAL Cloud Optimized GeoTIFF (COG) generator.
COPY --from=calvaluscalmar/calvalus-base:master /build/usr/lib/libgdal.so /opt/hadoop-$HADOOP_VERSION/lib/native/
COPY --from=calvaluscalmar/calvalus-base:master /build/usr/lib/libgdalalljni.so /opt/hadoop-$HADOOP_VERSION/lib/native/

HEALTHCHECK CMD curl -f http://localhost:8042/ || exit 1

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8042

CMD ["/run.sh"]
