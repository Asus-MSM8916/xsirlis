# XSIRLIS documentation
## Using XSIRLIS
1. Download it
2. Make xsirlis.sh executable
3. Run xsirlis.sh

## Adding a new ROM
1. Create a new empty file in res/rom with the name of your new ROM (do NOT use spaces).
2. Fill it out as follows:
* Type (ROM, RECOVERY)
* Android (9, 10)
* Manifest link
* Manifest branch
* [ROM] Default OTA link

## Adding a new device
1. Create a new empty folder in res/device with the name of your new device (do NOT use spaces).
2. Create a new empty folder in res/device/[devicename] with the name of your ROM (do NOT use spaces).
3. Create a new empty file in res/device/[devicename] named manifest.
4. Fill it out as follows:
* link branch path
5. [ROM] Create a new empty file in res/device/[devicename] named json.
6. [ROM] Fill it out as follows:
* Name of the json file
* Direct link to the zipfiles
* Tag of the ROM
* ROM type (OFFICIAL, UNOFFICIAL)
* ROM version
7. [ROM] Create a new empty file in res/device/[devicename] named ota.
8. [ROM] Fill it out as follows:
* Link to the json file

## Adding new Gapps
1. Create a new empty file in res/gapps/[android version] with the name of your new Gapps (do NOT use spaces).
4. Fill it out as follows:
* link branch path

## Adding new ROM patches
1. Create a new empty bash file in res/patches/[android version] with the name of your new patch (do NOT use spaces).
This will be applied after ROM, Gapps and device sync.

