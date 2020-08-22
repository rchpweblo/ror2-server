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
rm -r "${STEAMAPPDIR}"/bbepis-BepInExPack-5.3.1.zip "${STEAMAPPDIR}"/BepInExPack

echo "Downloading R2API"
wget -nc -P "${STEAMAPPDIR}"/BepInEx https://thunderstore.fra1.cdn.digitaloceanspaces.com/live/repository/packages/tristanmcpherson-R2API-2.5.6.zip

echo "Installing R2API"
7z x "${STEAMAPPDIR}"/BepInEx/tristanmcpherson-R2API-2.5.6.zip -o"${STEAMAPPDIR}"/BepInEx
rm -r "${STEAMAPPDIR}"/BepInEx/tristanmcpherson-R2API-2.5.6.zip "${STEAMAPPDIR}"/BepInEx/icon.png "${STEAMAPPDIR}"/BepInEx/manifest.json "${STEAMAPPDIR}"/BepInEx/README.md

echo "Downloading Bandit Reloaded"
wget -nc -P "${STEAMAPPDIR}"/BepInEx/plugins https://thunderstore.fra1.cdn.digitaloceanspaces.com/live/repository/packages/Moffein-BanditReloaded-2.1.2.zip

echo "Installing Bandit Reloaded"
7z x "${STEAMAPPDIR}"/BepInEx/plugins/Moffein-BanditReloaded-2.1.2.zip -o"${STEAMAPPDIR}"/BepInEx/plugins BanditReloaded.dll
rm -r "${STEAMAPPDIR}"/BepInEx/plugins/Moffein-BanditReloaded-2.1.2.zip

echo "Generating initial Wine configuration..."
/opt/wine-stable/bin/winecfg

echo "Let's wait :)"
sleep 5

echo "Starting server..."
xvfb-run /opt/wine-stable/bin/wine "${STEAMAPPDIR}/Risk of Rain 2.exe"
