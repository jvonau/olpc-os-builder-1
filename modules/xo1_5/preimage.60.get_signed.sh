. $OOB__shlib
get_signed_objects=$(read_config sd_card_image get_signed_objects

if [[ "get_signed_ojects" == 1 ]]; then
    echo "Adding signed content..."
    rm $fsmount//boot/bootfw1.zip
    rm $fsmount//boot/runos1.zip
    rm $fsmount//boot/runrd1.zip
    rm $fsmount//boot/actros.zip
    rm $fsmount//boot/actrd1.zip
    rsync rsync://updates.laptop.org/build-13.2.6_xo1.5-18/root/boot/bootfw1.zip $fsmount/boot/
    rsync rsync://updates.laptop.org/build-13.2.6_xo1.5-18/root/boot/runos1.zip $fsmount/boot/
    rsync rsync://updates.laptop.org/build-13.2.6_xo1.5-18/root/boot/runrd1.zip $fsmount/boot/
    rsync rsync://updates.laptop.org/build-13.2.6_xo1.5-18/root/boot/actos1.zip $fsmount/boot/
    rsync rsync://updates.laptop.org/build-13.2.6_xo1.5-18/root/boot/actrd1.zip $fsmount/boot/
fi
