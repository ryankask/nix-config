ssh_host := "sloth"

sync:
    rsync -av --exclude='.git' ./ {{ ssh_host }}:~/nix-config

switch:
    ssh {{ ssh_host }} "sudo nixos-rebuild switch"
