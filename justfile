ssh_host := "sloth"

sync:
    rsync -av --exclude='.git' ./ {{ ssh_host }}:~/nix-config

switch: && cp-flake-lock
    ssh {{ ssh_host }} "zsh -c 'sudo nixos-rebuild --flake ./nix-config#sloth switch'"

cp-flake-lock:
    rsync -av {{ ssh_host }}:~/nix-config/flake.lock .
