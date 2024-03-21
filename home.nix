{
  config,
  pkgs,
  lib,
  ...
}:

let
  user = "ryan";
  homeDir = "/home/${user}";
  dotfiles = "${homeDir}/nix-config/dotfiles";
  mkOutOfStoreDotfilesSymlink = fname: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${fname}";
in
{
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  home.username = user;
  home.homeDirectory = homeDir;
  home.packages = with pkgs; [
    bat
    emacs
    fd
    fzf
    git
    jq
    just
    rclone
    ripgrep
    xh
    xsv
    zoxide
    zsh
  ];
  home.file = {
    ".xprofile".text = ''
      # Ensure that ~/.zprofile is read
      [ -z "$ZSH_NAME" ] && exec $SHELL --login $0 "$@"
      [[ -o login ]] || exec $SHELL --login $0 "$@"
      emulate -R sh
    '';
    ".zlogin".source = ./dotfiles/zsh/zlogin;
    ".zprofile".text = ''
      export EDITOR='emacs'
      export VISUAL='emacs'
      export PAGER='less'
      export DOTFILES="$HOME/nix-config/dotfiles"
      typeset -gU cdpath fpath mailpath path
      export LESS='-F -g -i -M -R -S -w -X -z-4'
    '';
    ".zshenv".source = ./dotfiles/zsh/zshenv;
    ".zshrc".source = ./dotfiles/zsh/zshrc;
  };

  xdg.enable = true;
  xdg.configFile = {
    emacs.source = mkOutOfStoreDotfilesSymlink ".emacs.d";
    fd.source = ./dotfiles/.config/fd;
    git.source = ./dotfiles/.config/git;
    "starship.toml".source = ./dotfiles/.config/starship.toml;
  };

  programs.starship.enable = true;

  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod1";
      terminal = "kitty";
    };
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "Iosevka";
      size = 10;
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = false;
  };
}
