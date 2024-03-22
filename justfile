ssh_host := "sloth"

sync:
    rsync -av --delete --exclude=.git/ --exclude=flake.lock ./ {{ ssh_host }}:~/nix-config

switch: && cp-flake-lock
    ssh {{ ssh_host }} "zsh -c 'sudo nixos-rebuild --flake ./nix-config#sloth switch'"

cp-flake-lock:
    rsync -av {{ ssh_host }}:~/nix-config/flake.lock .
