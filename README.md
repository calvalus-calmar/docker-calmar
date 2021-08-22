
# Calvalus / CalMar on Hadoop Docker

## Background

The [CalMar project](https://github.com/calvalus-calmar "CalMar project") builds on the [Calvalus](https://github.com/bcdev/calvalus2 "Calvalus") and 
the [Hadoop Docker](https://github.com/big-data-europe/docker-hadoop "Hadoop Docker") projects. It deploys Calvalus on Hadoop Docker, and is used for processing earth observation data.
The overall project aims to demonstrate the processing and use of ocean satellite data products for use by the Marine Renewable Energy (MRE) sector.
CalMar is co-funded by [Science Foundation Ireland (SFI)](https://www.sfi.ie/ "Science Foundation Ireland (SFI)") and [Brockmann Consult](https://www.brockmann-consult.de/ "Brockmann Consult"). The research and development work is carried out by [MaREI](https://www.marei.ie/ "MaREI") in collaboration with [Brockmann Consult](https://www.brockmann-consult.de/ "Brockmann Consult").

This git repository packages the Hadoop/Calvalus development environment used by the Calmar project which includes:
* A single-node Hadoop cluster installation running on Docker
* Demo scripts to configure Calvalus on Docker Hadoop
* CalMar specific extensions, including:
    * Sentinel-1 Level-1 GRD terrain correction processor
    * Sentinel-1 Level-2 OCN geocoding processor
    * Sentinel-1 Level-2 OCN vertical wind shear processor
    * Demo of native GDAL support for Calvalus processing on Hadoop
    * Geospatial support for Calvalus 'quicklook' images (GeoTIFF and Cloud Optimized GeoTIFF)
    * Automatic upload to GeoServer for Calvalus 'quicklook' images 

## Prerequisites

These are required to run Calvalus / CalMar on Hadoop Docker:
* Docker and Docker Compose
* Docker configured with at least 8 GB of memory 

## Quick Start

### Deploy

Run the following command from the root directory of this repository in order to deploy
the single-node Hadoop cluster installation, GeoServer, and Calvalus:

```
docker-compose up -d
```

This starts the following Docker containers: 

* Hadoop NameNode
* Hadoop DataNode
* Hadoop NodeManager
* Hadoop ResourceManager
* Hadoop History Server
* Geoserver
* Calvalus Portal

Note that it may take a few minutes for the single-node Hadoop cluster to fully initialise after starting.

### Configure Calvalus on HDFS

Once the Hadoop cluster is up and running, the `calvalus-base` container can then be used to configure Calvalus. The `calvalus-base` container is
not deployed using `docker-compose`, instead it is a standalone container that can be started at any time to perform tasks
such as configuring  Calvalus, copy data onto the HDFS, run Calvalus jobs from command line, etc.

When first starting the `calvalus-base` container, it is useful to create a Docker volume for making persistent the container's home directory. 
A persistent home directory is not mandatory, but a convenient way to maintain information stored in the home directory for later use
such as command line history, custom scripts, etc. This is the command to create a Docker volume named `docker-calmar_calvalus_base_home`:
```
docker volume create docker-calmar_calvalus_base_home
```

After the volume is created, we can start the `calvalus-base` container from the root directory of this repository:
```
docker run --rm -it \
--network docker-calmar_default \
--env-file hadoop.env \
-v docker-calmar_calvalus_base_home:/root \
calvaluscalmar/calvalus-base:master \
bash
```

Next, within the `calvalus-base` container, run the demo configuration script, and then exit the container:
```
cd /config/
bash -x config.sh
exit
```
The script above installs:
* Calvalus to HDFS
* CalMar processors to HDFS
* Color palettes to HDFS for Calvalus quicklook

Once done, restart Docker Hadoop for the configuration changes to take effect:
```
docker-compose restart
```

### Configure Calvalus Portal

Once Calvalus is configured on HDFS, the `calvalus-portal` can be configured next.
First connect to its running container:
```
docker exec -it calvalus-portal bash
```

Within the `calvalus-portal` container, run the demo configuration script, and then exit the container.
```
cd /config/
bash -x config.sh
exit
```

The script above configures the:
* Default Tomcat username and password for the Calvalus portal
* Calvalus portal's calvalus.properties and color-palettes.properties files
* User defined color palettes and regions (in the ~/.calvalus/ directory)

After running the configuration script you need to restart the `calvalus-portal` container:
```
docker-compose restart calvalus-portal
```

Note that the default Tomcat username and password is root and calmar. These can be changed by editing the
`/opt/tomcat/conf/tomcat-users.xml` file within the `calvalus-portal` container. You must also restart the `calvalus-portal`
container for these changes to take effect.

### Configure GeoServer

To configure GeoServer, first connect to its running container:
```
docker exec -it geoserver bash
```

Within the `geoserver` container, run the demo configuration script, and then exit the container.
```
cd /config/
bash -x config.sh
exit
```
The script above configures:
* a new GeoServer workspace named `calmar`
* a global coastline dataset, styled in yellow, and named `calmar:ne_10m_coastline`

After running the configuration script you need to restart the `geoserver` container:
```
docker-compose restart geoserver
```

Note that the default GeoServer username and password is admin and geoserver.
These can be changed within the [Security](https://docs.geoserver.org/latest/en/user/security/index.html "GeoServer Security") panel in the GeoServer web UI.

### Web User Interfaces (UI)

The Hadoop Web UI services are accessible at:
*	Hadoop Resource Manager Web UI at: <http://localhost:8088/>
*	Hadoop Name Node Web UI at: <http://localhost:9870/>
*	Hadoop History Server Web UI at: <http://localhost:19888/>

The Calvalus portal is accessible at:
* <http://localhost:8080/calvalus-portal/calvalus.jsp>

GeoServer is accessible at:
* <http://localhost:8081/geoserver/web/>
