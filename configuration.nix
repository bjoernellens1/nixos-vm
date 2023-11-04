{ config, pkgs, ... }:

{
  imports = [ "qemu-guest.nix" ];

  services.openssh.enable = true;

  boot.initrd.availableKernelModules =
    [ "ata_piix" "uhci_hcd" "virtio_pci" "sr_mod" "virtio_blk" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  boot.kernelParams = [
    "console=tty1"
    "console=ttyS0,115200"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  fileSystems."/" = {
    device = "/dev/vda1";
    fsType = "ext4";
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    nano
    helix
    k3d
  ];

  users.users.bjoern = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    packages = with pkgs; [
      
    ];
    initialHashedPassword = $y$j9T$CYpeSdeCfTNi/FiiOn8dj/$W0eHq9U/WKgODUgNXPnS2AzS5GW9Km8O2dwgqSyW4fA;
  };

  virtualisation.docker.enable = true;
  services.qemuGuest.enable = true;

  # to enable proxmox network settings
  services.cloud-init.network.enable = true;
  
  system.stateVersion = "23.11";

}
