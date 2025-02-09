{ config, pkgs, ... }:

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
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.fnm
    pkgs.fd
    pkgs.neovim
    pkgs.uv
    pkgs.rustup
    pkgs.zoxide
    pkgs.fastfetch
    pkgs.uwufetch
    pkgs.awscli2
    pkgs.inetutils
    pkgs.k9s
    pkgs.kubectx
    pkgs.pre-commit
    pkgs.zig
    pkgs.jujutsu
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/fish/themes/mocha.theme".source = configs/fish/themes/mocha.theme;

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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/archuser/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
      enable = true;
      userName = "macroexpansion";
      userEmail = "macroexpansion@gmail.com";
      extraConfig = {
          init = {
              defaultBranch = "main";
          };
          pull = {
              rebase = true;
          };
          branch = {
              sort = "-committerdate";
          };
      };
  };

  programs.ripgrep = {
      enable = true;
  };

  programs.bottom = {
      enable = true;
      settings = {
          colors = {
            table_header_color = "#f5e0dc";
            all_cpu_color = "#f5e0dc";
            avg_cpu_color = "#eba0ac";
            cpu_core_colors = ["#f38ba8" "#fab387" "#f9e2af" "#a6e3a1" "#74c7ec" "#cba6f7"];
            ram_color = "#a6e3a1";
            swap_color = "#fab387";
            rx_color = "#a6e3a1";
            tx_color = "#f38ba8";
            widget_title_color = "#f2cdcd";
            border_color = "#585b70";
            highlighted_border_color = "#f5c2e7";
            text_color = "#cdd6f4";
            graph_color = "#a6adc8";
            cursor_color = "#f5c2e7";
            selected_text_color = "#11111b";
            selected_bg_color = "#cba6f7";
            high_battery_color = "#a6e3a1";
            medium_battery_color = "#f9e2af";
            low_battery_color = "#f38ba8";
            gpu_core_colors = ["#74c7ec" "#cba6f7" "#f38ba8" "#fab387" "#f9e2af" "#a6e3a1"];
            arc_color = "#89dceb";
          };
      };
  };

  programs.gh = {
      enable = true;
      settings = {
          version = "1";
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
      keyConfig = ./configs/gitui/key_bindings.ron;
      theme = ./configs/gitui/theme.ron;
  };

  programs.eza = {
      enable = true;
      git = true;
      icons = "auto";
  };

  programs.fish = {
      enable = true;
      shellInit = ''
        set fish_greeting # Disable greeting

        fish_add_path "${config.home.homeDirectory}/.nix-profile/bin"
        fish_add_path /nix/var/nix/profiles/default/bin
        fish_add_path /opt/homebrew/bin
        fish_add_path "${config.home.homeDirectory}/go/bin"
        fish_add_path "${config.home.homeDirectory}/.cargo/bin"
        fish_add_path "${config.home.homeDirectory}/.orbstack/bin"

        fnm env | source
      '';
      interactiveShellInit = ''
        fish_config theme choose mocha

        set -g fish_prompt_pwd_dir_length 1
        set -g theme_display_user yes
        set -g theme_hide_hostname no
        set -g theme_hostname always
        set -g fish_key_bindings fish_vi_key_bindings # Set Vi-mode key bindings

        zoxide init fish | source
      '';
      plugins = [
        # { name = "pure"; src = pkgs.fishPlugins.pure.src; }
        { name = "bass"; src = pkgs.fishPlugins.bass.src; }
        { name = "autopair"; src = pkgs.fishPlugins.autopair.src; }
        { name = "git"; src = pkgs.fishPlugins.plugin-git.src; }
      ];
      shellAliases = {
          ".." = "cd ..";
          "gitui" = "gitui -t theme.ron";
      };
      functions = {
          lash = {
              body = "ls -lash";
          };
      };
  };

  programs.kitty = {
      enable = true;
      shellIntegration = {
          mode = "disabled";
      };
      font = {
        name = "CaskaydiaCove Nerd Font Mono";
        package = pkgs.nerd-fonts.caskaydia-cove;
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
}
