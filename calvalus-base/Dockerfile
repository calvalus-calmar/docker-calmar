FROM calvaluscalmar/hadoop-base:master

LABEL Description="This image is used to enable shell access to setup and maintain data and processors for Calvalus" \
      Maintainer="Declan Dunne"

# Install prerequisites
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -q \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y -q --no-install-recommends \
      libssl1.1 \
      wget \
      build-essential \
      libproj-dev \
      python3-dev \
      swig \
      ant \
      git \
      maven \
      zip \
      vim \
    && rm -rf /var/lib/apt/lists/*

# GDAL (mininum GDAL build)
# The GDAL part of this script is part based on https://github.com/OSGeo/gdal/blob/master/gdal/docker/ubuntu-full/Dockerfile
ARG GDAL_VERSION=3.3.0

RUN mkdir gdal \
    && wget -q https://github.com/OSGeo/gdal/releases/download/v${GDAL_VERSION}/gdal-${GDAL_VERSION}.tar.gz -O - \
        | tar xz -C gdal --strip-components=1 \
    && cd gdal \
    && ./configure --prefix=/usr --without-libtool \
    --with-hide-internal-symbols \
    --with-jpeg=internal --with-jpeg12 \
    --with-libtiff=internal --with-rename-internal-libtiff-symbols \
    --with-geotiff=internal --with-rename-internal-libgeotiff-symbols \
    --with-proj \
    --with-java \
    --with-python \
    # make and install
    && make -j$(nproc) \
    && make install DESTDIR="/build" \
    # make and install java
    && cd swig/java/ \
    && make -j$(nproc) \
    && make install DESTDIR="/build" \
    && cd ../.. \
    # prepare install files
    && for i in /build/usr/lib/*.so; do strip -s $i 2>/dev/null || /bin/true; done \
    && for i in /build/usr/lib/python3/dist-packages/osgeo/*.so; do strip -s $i 2>/dev/null || /bin/true; done \
    && for i in /build/usr/bin/*; do strip -s $i 2>/dev/null || /bin/true; done \
    && mkdir -p /build/usr/share/java \
    && cp -p /gdal/swig/java/gdal.jar /build/usr/share/java \
    # remove gdal build files
    && cd .. \
    && rm -rf gdal

# Build Calvalus and its dependencies (SNAP and SNAP toolkits)
RUN set -x \
    && mkdir /snap \

    # Build snap-engine
    && cd /snap \
    && git clone https://github.com/calvalus-calmar/snap-engine.git \
    && cd snap-engine \
    && git checkout 8.x.calvalus \
    && mvn clean install -DskipTests \

    # Build snap-desktop
    && cd /snap \
    && git clone https://github.com/calvalus-calmar/snap-desktop.git \
    && cd snap-desktop \
    && git checkout 8.x.calvalus \
    && mvn clean install -DskipTests \

    # Build s1tbx
    && cd /snap \
    && git clone https://github.com/calvalus-calmar/s1tbx.git \
    && cd s1tbx \
    && git checkout 8.x.calvalus \
    && mvn clean install -DskipTests \

    # Build s2tbx
    && cd /snap \
    && git clone https://github.com/calvalus-calmar/s2tbx.git \
    && cd s2tbx \
    && git checkout 8.x.calvalus \
    && mvn clean install -DskipTests \

    # Build s3tbx
    && cd /snap \
    && git clone https://github.com/calvalus-calmar/s3tbx.git \
    && cd s3tbx \
    && git checkout 8.x.calvalus \
    && mvn clean install -DskipTests \

    # Build calvalus
    && mkdir /calvalus \
    && cd /calvalus \
    && git clone https://github.com/calvalus-calmar/calvalus2.git \
    && cd calvalus2 \
    && git checkout calmar-develop \
    && mvn clean install -DskipTests \

    # Build calmar processors
    && mkdir /calmar \
    && cd /calmar \
    && git clone https://github.com/calvalus-calmar/calmar-processors.git \
    && cd calmar-processors \
    && git checkout master \
    && mvn clean install -DskipTests \

    # Prepare install files
    && cd / \
    # calvalus-distribution
    && mkdir -p /build/usr/share/java/calvalus/calvalus-distribution/ \
    && cp -p /calvalus/calvalus2/calvalus-distribution/target/cpt.jar /build/usr/share/java/calvalus/calvalus-distribution \
    # calvalus-bundle
    && mkdir -p /build/usr/share/java/calvalus/calvalus-bundle/ \
    && cp -p /calvalus/calvalus2/calvalus-distribution/target/calvalus-bundle/*.jar /build/usr/share/java/calvalus/calvalus-bundle/ \
    # calvalus-bundle
    && mkdir -p /build/usr/share/java/calvalus/calvalus-portal/ \
    && cp -p /calvalus/calvalus2/calvalus-portal/target/calvalus-portal.war /build/usr/share/java/calvalus/calvalus-portal/ \
    # snap-bundle
    && mkdir -p /build/usr/share/java/calvalus/snap-bundle/ \
    && cp -p /calvalus/calvalus2/calvalus-snap/target/snap-bundle/snap-all.jar /build/usr/share/java/calvalus/snap-bundle/ \
    # snap bundle-descriptor
    && mkdir -p /build/usr/share/java/calvalus/snap-bundle/resources/ \
    && cp -p /calvalus/calvalus2/calvalus-snap/src/main/resources/bundle-descriptor.xml /build/usr/share/java/calvalus/snap-bundle/resources/ \
    # snap-python
    && mkdir -p /build/usr/share/java/calvalus/snap-python/ \
    && cp -p `/bin/ls -1 /snap/snap-engine/snap-python/target/snap-python*.jar |grep -v "sources" | grep -v "tests"` /build/usr/share/java/calvalus/snap-python/ \
    && cp -p /snap/snap-engine/snap-python/target/nbm/netbeans/snap/modules/ext/org.esa.snap.snap-python/org-jpy/jpy.jar /build/usr/share/java/calvalus/snap-python/ \
    # s1tbx
    && mkdir -p /build/usr/share/java/calvalus/s1tbx/ \
    && cp -p `/bin/ls -1 /snap/s1tbx/s1tbx*/target/*.jar |grep -v "tests" | grep -v "sources"` /build/usr/share/java/calvalus/s1tbx/ \
    # s2tbx
    && mkdir -p /build/usr/share/java/calvalus/s2tbx/ \
    && cp -p `/bin/ls -1 /snap/s2tbx/s2tbx*/target/*.jar |grep -v "tests" | grep -v "sources"` /build/usr/share/java/calvalus/s2tbx/ \
    # s3tbx
    && mkdir -p /build/usr/share/java/calvalus/s3tbx/ \
    && cp -p `/bin/ls -1 /snap/s3tbx/s3tbx*/target/*.jar |grep -v "tests" | grep -v "sources"` /build/usr/share/java/calvalus/s3tbx/ \
    # calmar
    && mkdir -p /build/usr/share/java/calvalus/calmar/ \
    && cp -p /calmar/calmar-processors/calmar-ocean-wind-energy-preprocess/target/calmar-ocean-wind-energy-op-0.1.0-SNAPSHOT.jar /build/usr/share/java/calvalus/calmar/ \
    # remove build files
    && rm -rf /snap /calvalus /calmar \
    && rm -rf ~/.m2

ENV LD_LIBRARY_PATH=/build/usr/lib/
ENV PATH /build/usr/bin/:$PATH

ADD config /config

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
