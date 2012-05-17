
My kickstart files to build a minimal installation of CentOS/ScientificLinux
using VirtualBox. This minimal installation will be used to build a vagrant
box.

Files
-----
bin/read-comps-xml.rb       - get packages from comps.xml to be used in a new kickstart.
bin/vbox-boot-dvd.sh        - VirtualBox: set boot to dvd iso
bin/vbox-boot-hd.sh         - VirtualBox: set boot to disk
bin/vbox-linux-server.sh    - VirtualBox: create a new linux machine
comps/comps-centos56.xml    - Centos56 iso: /repodata/comps.xml
comps/comps-centos57.xml    - Centos57 iso: /repodata/comps.xml
comps/comps-centos58.xml    - Centos58 iso: /repodata/comps.xml
comps/comps-centos62.xml    - Centos62 iso: /repodata/comps.xml
comps/comps-sl60.xml        - Scientific 6.0 iso: /repodata/comps.xml
comps/comps-sl61.xml        - Scientific 6.1 iso: /repodata/comps.xml
extra/installed.*.txt       - result list of installed packages.
vhost/vhost-ks.conf         - Apache: example vhost
c.xml                       - Source: grep -v 'xml:lang' comps/comps-centos62.xml > c.xml
ks56.cfg                    - initial for centos56
ks57.cfg                    - link -> current
ks57-0.cfg                  - centos57: 193 packages (initial)
ks57-1.cfg                  - centos57: 156 packages
ks57-2.cfg                  - centos57: 143 packages
ks57-3.cfg                  - centos57: 131 packages
ks57-4.cfg                  - centos57: 125 packages
ks57-5.cfg                  - centos57: 143 packages
ks57-6.cfg                  - centos57: 143 packages + pwconv (current)
ks58.cfg                    - centos58: 152 packages (current)
ks62.cfg                    - link -> current
ks62-0.cfg                  - centos62: 164 packages (initial)
ks62-1.cfg                  - centos62: 161 packages (minimal)
ks62-2.cfg                  - centos62: 243 packages
ks62-3.cfg                  - centos62: 202 packages (current)
vagrant-post-additions.cfg  - snippet: post tasks to create 'vagrant' user

