#!/bin/bash

echo "setting variables"

INSTALL_DIR="/opt/app-jenkins/custom_deploy/install_dir"
WORK_DIR="/tmp/target"
POM_VERSION=$(cat $WORK_DIR/app-java-jenkins-version.properties)
PACKAGE_PATH="${WORK_DIR}/app-java-jenkins-$POM_VERSION-dist.zip"

echo "creating install dir"
mkdir -p ${INSTALL_DIR}

echo "unzipping package"
unzip -q -o ${PACKAGE_PATH} -d ${INSTALL_DIR}

if [ -f ${INSTALL_DIR}/current/stop.sh ]
then
echo "chmoding stop.sh"
chmod 0750 ${INSTALL_DIR}/current/stop.sh
echo "stopping"
${INSTALL_DIR}/current/stop.sh
fi

echo "removing old symlink"
rm -f ${INSTALL_DIR}/current
echo "creating new symlink"
ln -s ${INSTALL_DIR}/app-java-jenkins-${POM_VERSION} ${INSTALL_DIR}/current

echo "chmodding new scripts"
chmod 0750 ${INSTALL_DIR}/current/start.sh
chmod 0750 ${INSTALL_DIR}/current/stop.sh

echo "starting"
${INSTALL_DIR}/current/start.sh
