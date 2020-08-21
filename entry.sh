#!/bin/bash

echo "Updating Risk of Rain 2 server..."
"${STEAMCMDDIR}/steamcmd.sh" +login anonymous +force_install_dir "${STEAMAPPDIR}" +@sSteamCmdForcePlatformType windows +app_update "${STEAMAPPID}" +quit

echo "Generating server configuration..."
envsubst < "default_config.cfg" > "${STEAMAPPDIR}/Risk of Rain 2_Data/Config/server.cfg"

echo "Downloading BepInEx..."
wget -P "${STEAMAPPDIR}" https://github.com/BepInEx/BepInEx/releases/download/v5.3/BepInEx_x64_5.3.0.0.zip

echo "Installing BepInEx..."
7z x "${STEAMAPPDIR}"/BepInEx_x64_5.3.0.0.zip -o"${STEAMAPPDIR}"
rm "${STEAMAPPDIR}"/BepInEx_x64_5.3.0.0.zip "${STEAMAPPDIR}"/changelog.txt

echo "Generating initial Wine configuration..."
/opt/wine-stable/bin/winecfg

echo "Let's wait :)"
sleep 5

echo "Starting server..."
xvfb-run /opt/wine-stable/bin/wine "${STEAMAPPDIR}/Risk of Rain 2.exe"
