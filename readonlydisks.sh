#!/bin/bash

# Get connected external disk
diskList=$(diskutil list | grep "external" | cut -d " " -f1)

# Get list of connected external disks partitions
partitionList=$(diskutil list $diskList | awk '{print $NF}' | grep -v "IDENTIFIER" | grep -v "physical" | sed '1d')

# Add all found disk partitions to an array
array=(`echo ${partitionList}`)

# Loop through array to get the UUID of each partition, then add it to fstab as read only
for element in "${array[@]}"
  do
      diskUUID=$(diskutil info $element | grep "Volume UUID:" | awk '{print $NF}')
      diskType=$(diskutil info disk2s3 | grep "Type (Bundle):" | awk '{print $NF}')
      echo "UUID="$diskUUID"\tnone\t"$diskType"\tro" | sudo tee -a /etc/fstab
  done

# Unmount and remount the disk for fstab to be read
diskutil unmountDisk $diskList
diskutil mountDisk $diskList
