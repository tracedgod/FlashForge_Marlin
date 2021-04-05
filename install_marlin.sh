#!/usr/bin/env bash

PRINTER_TYPE="${1:-dreamer_nx}"
RELEASE_VERSION="${2:-0.4}"
RELEASE_NAME="marlin_${PRINTER_TYPE}"
TARGET_RELEASE_NAME="${RELEASE_NAME}_v${RELEASE_VERSION}.bin"
FLASHFORGE_MARLIN_RELEASE_URL="https://github.com/moonglow/FlashForge_Marlin/releases/download/v${RELEASE_VERSION}/${RELEASE_NAME}.bin"

echo "Downloading FlashForge_Marlin v${RELEASE_VERSION}"

wget -q "${FLASHFORGE_MARLIN_RELEASE_URL}" 2> /dev/null
if [ $? != 0 ]; then
  echo "release does not exist, exiting..."
  exit 1
fi

mv "${RELEASE_NAME}.bin" ${TARGET_RELEASE_NAME}

echo "Flashforge Marlin downloaded: ${TARGET_RELEASE_NAME}"


echo "Flashing ${TARGET_RELEASE_NAME} to FlashForge"
echo "***********"
echo "Ready to Flash"
echo "***********"
read  -n 1 -p " Switch off your printer and connect to this computer via USB. When your are ready, switch on printer and press enter!"

./ff_flash_firmware.py ${TARGET_RELEASE_NAME}