# nixos-vm


## Produce KVM image for proxmox
```
nix run github:nix-community/nixos-generators -- --format proxmox --configuration configuration.nix
```

### Deploy on proxmox
copy to host and restore vzdump
```
qmrestore /var/lib/vz/dump/vzdump-qemu-nixos-21.11.git.d41882c7b98M.vma.zst <vmid> --unique true
```

## Produce LXC image for proxmox
```
nix run github:nix-community/nixos-generators -- --format proxmox-lxc
```

add following to configuration.nix

```
{ pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  environment.systemPackages = [
    pkgs.vim
  ];
}
```

## References
https://nixos.wiki/wiki/Proxmox_Virtual_Environment