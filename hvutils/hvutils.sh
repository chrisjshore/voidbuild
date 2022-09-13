#!/bin/bash

export srctree=${PWD}/hvutils
mkdir -p hvutils/tools/{hv,scripts,build}
wget https://raw.githubusercontent.com/torvalds/linux/v5.15/tools/hv/Build -P hvutils/tools/hv
wget https://raw.githubusercontent.com/torvalds/linux/v5.15/tools/hv/Makefile -P hvutils/tools/hv
wget https://raw.githubusercontent.com/torvalds/linux/v5.15/tools/hv/hv_fcopy_daemon.c -P hvutils/tools/hv
wget https://raw.githubusercontent.com/torvalds/linux/v5.15/tools/hv/hv_get_dhcp_info.sh -P hvutils/tools/hv
wget https://raw.githubusercontent.com/torvalds/linux/v5.15/tools/hv/hv_kvp_daemon.c -P hvutils/tools/hv
wget https://raw.githubusercontent.com/torvalds/linux/v5.15/tools/hv/hv_set_ifconfig.sh -P hvutils/tools/hv
wget https://raw.githubusercontent.com/torvalds/linux/v5.15/tools/hv/hv_vss_daemon.c -P hvutils/tools/hv
wget https://raw.githubusercontent.com/torvalds/linux/v5.15/tools/hv/lsvmbus -P hvutils/tools/hv
wget https://raw.githubusercontent.com/torvalds/linux/v5.15/tools/hv/vmbus_testing -P hvutils/tools/hv
wget https://raw.githubusercontent.com/torvalds/linux/v5.15/tools/scripts/Makefile.include -P hvutils/tools/scripts
wget https://raw.githubusercontent.com/torvalds/linux/v5.15/tools/build/Build.include -P hvutils/tools/build
wget https://raw.githubusercontent.com/torvalds/linux/v5.15/tools/build/Makefile.build -P hvutils/tools/build
wget https://raw.githubusercontent.com/torvalds/linux/v5.15/tools/build/Makefile.include -P hvutils/tools/build
cd hvutils/tools/hv && make
make install

mkdir -p /etc/sv/{hvfcopy,hvkvp,hvvss}
wget https://bitbucket.org/Cshore/voidbuild/raw/4f898195648d5e293c7d746a651d43f318f2ffba/hvutils/hvfcopy/run -P /etc/sv/hvfcopy
wget https://bitbucket.org/Cshore/voidbuild/raw/4f898195648d5e293c7d746a651d43f318f2ffba/hvutils/hvkvp/run -P /etc/sv/hvkvp
wget https://bitbucket.org/Cshore/voidbuild/raw/4f898195648d5e293c7d746a651d43f318f2ffba/hvutils/hvvss/run -P /etc/sv/hvvss

ln -s /etc/sv/hvfcopy /var/service/hvfcopy
ln -s /etc/sv/hvkvp /var/service/hvkvp
ln -s /etc/sv/hvvss /var/service/hvvss

sv start hvfcopy
sv start hvkvp
sv start hvvss