# Copyright (C) 2009 One Laptop Per Child
# Licensed under the terms of the GNU GPL v2 or later; see COPYING for details.

# this must be run before the base module creates versioned fs layout

. $OOB__shlib

#echo "Installing kernel rpm manually..."
rpm --root "$fsmount" --ignorearch -ivh $oob_config_dir/kernel-2.6.39_xo1.75-20110621.1628.olpc.2b77a83.armv7l.rpm

# FIXME olpc.fth usually comes in the bootfw rpm
# This olpc.fth compensates for lack of /ofw to trigger runin
cat > $fsmount/boot/olpc.fth <<"EOF"
\ olpc.fth
: runin? " TS" find-tag if
        ?-null " RUNIN" nocase-$= if
                true
                exit
        then
  then
  false
;

" root=/dev/mmcblk0p2 console=ttyS2,115200 console=tty0 loglevel=9 rootwait debug" to boot-file
runin? if boot-file "  runin" $cat2 to boot-file then
boot last:\vmlinuz

EOF
