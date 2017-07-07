#!/bin/bash 

APP_NAME=${1}
VERSION=${2}
INSTALL_DIR="/opt/${APP_NAME}/custom_deploy/install_dir"
WORK_DIR="/tmp"
PACKAGE_FILE="${WORK_DIR}/${APP_NAME}-${VERSION}.tar.gz"
ARCHIVE_DIR="/opt/${APP_NAME}/custom_deploy/archive"

mkdir -p ${INSTALL_DIR}
mkdir -p ${ARCHIVE_DIR}

supervisorctl stop ${APP_NAME}-custom-deploy

if [ -f ${PACKAGE_FILE} ]; then 
  tar zxf "${PACKAGE_FILE}" -C "${INSTALL_DIR}"
fi

if [ -L ${INSTALL_DIR}/current ]; then 
  rm -f ${INSTALL_DIR}/current
fi 

ln -s ${INSTALL_DIR}/${VERSION} ${INSTALL_DIR}/current

supervisorctl start ${APP_NAME}-custom-deploy
mv ${PACKAGE_FILE} ${ARCHIVE_DIR}
