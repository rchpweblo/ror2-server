#!/bin/bash

echo "Updating Risk of Rain 2 server..."
"${STEAMCMDDIR}/steamcmd.sh" +login anonymous +force_install_dir "${STEAMAPPDIR}" +@sSteamCmdForcePlatformType windows +app_update "${STEAMAPPID}" +quit

echo "Generating server configuration..."
envsubst < "default_config.cfg" > "${STEAMAPPDIR}/Risk of Rain 2_Data/Config/server.cfg"

echo "Downloading BepInEx..."
wget -nc -P "${STEAMAPPDIR}" https://thunderstore.fra1.cdn.digitaloceanspaces.com/live/repository/packages/bbepis-BepInExPack-5.3.1.zip

echo "Installing BepInEx..."
7z x "${STEAMAPPDIR}"/bbepis-BepInExPack-5.3.1.zip -o"${STEAMAPPDIR}" BepInExPack
mv "${STEAMAPPDIR}"/BepInExPack/BepInEx/ "${STEAMAPPDIR}"/BepInExPack/doorstop_config.ini "${STEAMAPPDIR}"/BepInExPack/winhttp.dll -t "${STEAMAPPDIR}"
rm -r "${STEAMAPPDIR}"/BepInEx_x64_5.3.0.0.zip "${STEAMAPPDIR}"/BepInExPack/

echo "Generating initial Wine configuration..."
/opt/wine-stable/bin/winecfg

echo "Let's wait :)"
sleep 5

echo "Starting server..."
xvfb-run /opt/wine-stable/bin/wine "${STEAMAPPDIR}/Risk of Rain 2.exe"
