host := ""
nix_host := if host != "" {
  host
} else {
  error("host variable must be set")
}

sync:
    rsync -av --delete --exclude=.git/ --exclude=flake.lock ./ {{ nix_host }}:~/nix-config

switch: && cp-flake-lock
    ssh {{ nix_host }} "zsh -c 'sudo nixos-rebuild --flake ./nix-config#{{ nix_host }} switch'"

cp-flake-lock:
    rsync -av {{ nix_host }}:~/nix-config/flake.lock .
