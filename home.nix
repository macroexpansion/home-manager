{ config, lib, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "archuser";
  home.homeDirectory = "/Users/archuser";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/archuser/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
      enable = true;
      userName = "macroexpansion";
      userEmail = "trasuadev@gmail.com";
      extraConfig = {
          init = {
              defaultBranch = "main";
          };
          pull = {
              rebase = true;
          };
      };
  };

  programs.kitty = {
      enable = true;
      shellIntegration = {
          mode = "disabled";
      };
      font = {
        name = "Cascadia Code";
        package = pkgs.nerdfonts.override { fonts = ["CascadiaCode"]; };
        size = 14;
      };
      settings = {
# font_family         = "Cascadia Code SemiBold";
# bold_font           = "Cascadia Code Bold";
# italic_font         = "Cascadia Code SemiBold";
# bold_italic_font    = "Cascadia Code Bold";
        disable_ligatures   = "never";
        cursor_shape = "block";
        shell_integration = "disabled";
        background = "#282a36";
        foreground = "#ffffff";
        color0 = "#282c34";
        color8 = "#ffffff";
        color1 = "#be5046";
        color9 = "#e06c75";
        color10 = "#1cdc9a";
        color2 = "#1abc9c";
        color3 = "#e5c07b";
        color11 = "#e5d660";
        color4 = "#56b6c2";
        color12 = "#14ffff";
        color13 = "#cb1ed1";
        color5 = "#c678dd";
        color6 = "#61afef";
        color14 = "#1a8fff";
        color7 = "#dddddd";
        color15 = "#ffffff";
        tab_bar_edge = "top";
        tab_bar_style = "powerline";
        hide_window_decorations = "yes";
        macos_option_as_alt = "yes";
      };
  };

  programs.ripgrep = {
      enable = true;
  };

  programs.bottom = {
      enable = true;
  };

  programs.gh = {
      enable = true;
      settings = {
          git_protocol = "ssh";
          prompt = "enabled";
      };
      gitCredentialHelper = {
          enable = true;
          hosts = ["https://github.com"];
      };
  };
}
