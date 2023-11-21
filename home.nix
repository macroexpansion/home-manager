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
        disable_ligatures = "never";
        cursor_shape = "block";
        shell_integration = "disabled";
        tab_bar_min_tabs = 1;
        tab_bar_edge = "bottom";
        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";
        tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
        hide_window_decorations = "yes";
        macos_option_as_alt = "yes";

        foreground = "#CDD6F4";
        background = "#1E1E2E";
        selection_foreground = "#1E1E2E";
        selection_background = "#F5E0DC";

        color0 = "#45475A";
        color8 = "#585B70";

        color1 = "#F38BA8";
        color9 = "#F38BA8";

        color2 = "#A6E3A1";
        color10 = "#A6E3A1";

        color3 = "#F9E2AF";
        color11 = "#F9E2AF";

        color4 = "#89B4FA";
        color12 = "#89B4FA";

        color5 = "#F5C2E7";
        color13 = "#F5C2E7";

        color6 = "#94E2D5";
        color14 = "#94E2D5";

        color7 = "#BAC2DE";
        color15 = "#A6ADC8";

        cursor            = "#F5E0DC";
        cursor_text_color = "#1E1E2E";

        url_color = "#F5E0DC";

        active_border_color   = "#B4BEFE";
        inactive_border_color = "#6C7086";
        bell_border_color     = "#F9E2AF";

        wayland_titlebar_color = "system";
        macos_titlebar_color = "system";

        active_tab_foreground   = "#11111B";
        active_tab_background   = "#CBA6F7";
        inactive_tab_foreground = "#CDD6F4";
        inactive_tab_background = "#181825";
        tab_bar_background      = "#11111B";

        mark1_foreground = "#1E1E2E";
        mark1_background = "#B4BEFE";
        mark2_foreground = "#1E1E2E";
        mark2_background = "#CBA6F7";
        mark3_foreground = "#1E1E2E";
        mark3_background = "#74C7EC";
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

  programs.gitui = {
      enable = true;
  };
}
