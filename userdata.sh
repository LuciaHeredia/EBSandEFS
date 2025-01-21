#!/bin/bash

# Set the device name and mount point for the EBS volume
EBS_DEVICE=/dev/xvd*
MOUNT_POINT=/mnt/<ebs-volume-folder-name>

# Check if the EBS volume is already attached
if [ -b "$EBS_DEVICE" ]; then
  # Create a file system on the EBS volume if it's empty
  if ! blkid "$EBS_DEVICE" | grep -q "Filesystem"; then
    mkfs -t ext4 "$EBS_DEVICE"
  fi

  # Mount the EBS volume
  mount "$EBS_DEVICE" "$MOUNT_POINT"
  echo "Mounted $EBS_DEVICE to $MOUNT_POINT"
else
  echo "EBS volume not attached or not found"
  exit 1
fi

# Add an entry to /etc/fstab to mount the EBS volume automatically on boot
echo "UUID=$(blkid -o value -s UUID "$EBS_DEVICE") $MOUNT_POINT ext4 defaults,nofail 0 2" >> /etc/fstab

# Update the system's fstab file
sudo mount -a
