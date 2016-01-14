
echo "path is $PATH"
export PATH=/usr/bin:/usr/sbin:/sbin:/bin:$PATH
echo "path is $PATH"

#enable updates-testing till the mirrors straighen out
sed -i 's|enabled=0|enabled=1|' /etc/yum.repos.d/fedora-updates-testing.repo
sed -i 's|enabled=0|enabled=1|' /etc/yum.repos.d/fedora-updates.repo

yum -y install git ansible

# make the default install path
mkdir -p /opt/schoolserver
cd /opt/schoolserver

### release flow
git clone --depth 1 --branch  build_freeze https://github.com/XSCE/xsce 
#cd xsce
#git branch <ver> 
#git checkout <ver> 
#git pull origin <ver>

### custom testing branch
#git clone --depth 1 --branch ks-files4 https://github.com/jvonau/xsce 
cd xsce
git checkout -b installer

## set preload time options here

# Don't start services while in the chroot
# turn on and off what you want to preload for other than default
cat > /opt/schoolserver/xsce/vars/local_vars.yml << EOF
installing: True

dhcpd_install: True
named_install: True
dansguardian_install: True
squid_install: True
openvpn_install: True

postgresql_install: True
mysql_install: True

samba_install: True
authserver_install: True
usb_lib_install: True
ejabberd_install: True
idmgr_install: True
activity-server_install: True
elgg_install: True
owncloud_install: True
moodle_install: True
iiab_install: True
pathagar_install: True
rachel_install: True
kiwix_install: True
sugar_stats_install: True
ajenti_install: True
munin_install: True
monit_install: True
vnstat_install: True
awstats_install: True
xovis_install: True
teamviewer_install: False
kalite_install: False
wordpress_install: False

EOF

./runtags download,download2 | tee -a xsce-image.log

## set install time options here

# Don't start services while in the chroot
cat > /opt/schoolserver/xsce/vars/local_vars.yml << EOF
installing: True
osbuilder: True
EOF

### prep the image
./install-console | tee -a xsce-kickstart.log

# get rid of custom local_vars
#git reset --hard 
#git checkout master
