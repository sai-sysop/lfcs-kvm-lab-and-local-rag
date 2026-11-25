#!/usr/bin/env bash
set -euo pipefail

# Prerequisites on Ubuntu 26.04 LTS:
# sudo apt install -y qemu-system-x86 libvirt-daemon-system libvirt-clients qemu-utils virtinst xorriso ovmf wget

IMG_DIR="/var/lib/libvirt/images"

sudo virt-install \
  --name lfcs-rocky9 \
  --memory 1536 --vcpus 2 \
  --cpu host-passthrough \
  --machine q35 \
  --boot uefi,loader_secure=no \
  --import --osinfo rocky9 \
  --disk path="${IMG_DIR}/lfcs-rocky9.qcow2",format=qcow2,bus=virtio \
  --disk path="${IMG_DIR}/lfcs-rocky9-scratch.qcow2",format=qcow2,bus=virtio \
  --network network=default,model=virtio \
  --graphics none --console pty,target_type=serial \
  --cloud-init user-data="${IMG_DIR}/lfcs-user-data.yaml"
