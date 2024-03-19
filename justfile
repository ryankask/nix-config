ssh_host := "sloth"

sync:
    rsync -av --exclude='.git' ./ {{ ssh_host }}:~/nix-config

switch:
    ssh {{ ssh_host }} "/run/current-system/sw/bin/zsh -c 'cd /etc/nixos; sudo nixos-rebuild --flake .#sloth switch'"
