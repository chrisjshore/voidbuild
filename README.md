# Void Linux LXQt Build Guide

This guide assumes you know how to install Void into a VM.  I may add those steps in the future.  Run the below command to start the installer.  When building as a Generation 2 VM in Hyper-V you will also need to create an EFI boot partition.

``` bash
void-installer
```

Update the repo and install updates

``` bash
xbps-install -Su
```

After installing the OS and updating the repo, login as root and install these base packages.

``` bash
xbps-install lxqt sddm -y
```

Now we need to install xinit and window manager junk.

``` bash
xbps-install xinit xauth xprop compton compton-conf -y
```

Next we need to install video, audio, and keyboard drivers, plus some fonts.

``` bash
xbps-install xorg-input-drivers xorg-video-drivers pulseaudio kbd-data dejavu-fonts-ttf font-misc-misc terminus-font -y
```

These packages are required if you want to see the Trash can and have access to the Computer icon.

``` bash
xbps-install gvfs gvfs-afc gvfs-mtp gvfs-smb -y
```

Create symbolic links to the service manager.

``` bash
ln -s /etc/sv/dbus /var/service/dbus
ln -s /etc/sv/sddm /var/service/sddm
ln -s /etc/sv/elogind /var/service/elogind
ln -s /etc/sv/polkitd /var/service/polkitd
```

Create a .xinitrc file in the /root folder. 

``` bash
#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

pipewire &
exec startlxqt
```

*Rant:* The main takeaway here is __*pipewire &*__.  The startlxqt script in /sbin sets some XDG environment variables and launches lxqt-session.  If you get a segfault you can insert gdb into the call to lxqt-session, but having pipewire in this script should avoid having to do that.

There's no web browser by default so lets install Chromium.

Install Chromium:
``` bash
xbps-install chromium -y
```

Now reboot and you should be greeted with the sddm login screen.


Quick Fixes:

Enable Compton:  *Preferences* > *LXQt Settings* > *Session Settings* > check box next to *Compton (X Compositor)* > make sure row is highlighted then click *Start*

Default Terminal: *Accessories* > *PCManFM-Qt File Manager* > *Edit* > *Preferences* > *Advanced* > change *Terminal Emulator* to *qterminal*

Auto login:  Create */etc/sddm.conf* and set it to the below values where anon is the user you created during install.
```
[Autologin]
User=anon
Session=lxqt.desktop
```

Enjoy your new Void build!  :)