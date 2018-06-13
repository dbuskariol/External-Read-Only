# External Read Only

This script looks at an external disk, gets all the partitions and adds a read-only flag into `/etc/fstab` with the `UUID` of each partition. 

You can set this script to be called when any external device is plugged in to disable write access to all external disks. 

TODO:
- [ ] Get the $diskList in a loop in case multiple disks are in use
- [ ] Perform a check for encrypted disks and only write to /etc/fstab if unencrypted
