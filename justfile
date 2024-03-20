ssh_host := "sloth"

sync:
    rsync -av --exclude='.git' ./ {{ ssh_host }}:~/nix-config

switch:
    ssh {{ ssh_host }} "zsh -c 'sudo nixos-rebuild --flake ./nix-config#sloth switch'"
