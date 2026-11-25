# KVM / libvirt Lifecycle Reference (Ubuntu 26.04 Host)

- Validate KVM host prerequisites: `virt-host-validate qemu`
- List all VMs: `virsh list --all`
- Check NAT DHCP leases: `virsh net-dhcp-leases default`
- Attach serial console (detach with Ctrl+]): `virsh console lfcs-rocky9`
- Create offline snapshot: `virsh snapshot-create-as lfcs-rocky9 clean-base "Fresh Rocky 9.9 + 5G scratch"`
- Revert broken lab VM: `virsh destroy lfcs-rocky9 && virsh snapshot-revert lfcs-rocky9 clean-base && virsh start lfcs-rocky9`
