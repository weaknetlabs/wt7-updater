# wt7-updater
This tool will perform all necessary updates to WT7 to avoid having to re-download the VMWare ISO images each time. It will store a file on your WT system ```/etc/wt-version``` which will be checked against whatever output comes from the file https://weaknetlabs.com/linux/update-wt/update.php This will determine what file to pull down if an update is accepted by the user. E.G. The update 7.5 will pull the file https://weaknetlabs.com/linux/update-wt/7.5.txt create an executable out of it and run it. The ```update.php``` file will always reflect the latest stable version of the update.

_Screenshot: Installation, setup, and running of the script._

<img src="https://weaknetlabs.com/images/wt7-updater-04.PNG" />

This tool will also create a menu entry in your FluxBox desktop menu to update WT which you can then run whenever you wish as shown in the screenshot below to check for, and download and install updates,

_Screenshot: Menu entry added to the Desktop_

<img src="https://weaknetlabs.com/images/update-success.png"/>

_Screenshot: Grub2 Splash Screen updated in the 7.5 update to WT7 BETA_

<img src="https://weaknetlabs.com/images/grub-splash-update.png" />

## Installation
Simply run the script after downloading it as shown in the screenshot above. From then, you can simply choose it from the desktop menu under ```OS Utilities->Update WT (experimental!)```
