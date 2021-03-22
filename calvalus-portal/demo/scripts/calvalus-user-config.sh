#!/bin/bash
# Add custom user configuration files

USERNAME=$(whoami)
DIRECTORY=~/.calvalus/

if [ ! -d "$DIRECTORY" ]
then
  mkdir ${DIRECTORY}
fi

#################################################
# 1 - Add custom user regions file              #
#################################################
USER_REGIONS_PATH=${DIRECTORY}${USERNAME}-regions.properties
COMMENT="# Register user '${USERNAME}' regions for calvalus portal"
if [ ! -f "${USER_REGIONS_PATH}" ] || ! grep -q "${COMMENT}" $USER_REGIONS_PATH; then
  cat > $USER_REGIONS_PATH << EOF
$COMMENT
#
# Example entry registering extents for Ireland
user.Cork=POLYGON((-7.8 52.0, -7.8 51.5, -8.7 51.5, -8.7 52.0, -7.8 52.0))
user.Ireland=POLYGON((-5.0 56.0, -5.0 51.0, -11.0 51.0, -11.0 56.0, -5.0 56.0))
EOF
fi

#################################################
# 2 - Add custom user palettes file             #
#################################################
USER_PALETTES_PATH=${DIRECTORY}${USERNAME}-color-palettes.properties
FILE_SYSTEM_HOST=${CORE_CONF_fs_defaultFS}
COMMENT="# Register user '${USERNAME}' color palettes for calvalus portal"
if [ ! -f "${USER_PALETTES_PATH}" ] || ! grep -q "${COMMENT}" $USER_PALETTES_PATH; then
  cat > $USER_PALETTES_PATH << EOF
$COMMENT
#
# Example entry registering sar.cpd
sar = $FILE_SYSTEM_HOST/calvalus/auxiliary/cpd/sar.cpd
EOF
fi
