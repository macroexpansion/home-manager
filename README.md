# Nix home-manager

```bash
nix-channel --list
# home-manager https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz
# nixos-unstable https://nixos.org/channels/nixpkgs-unstable
# unstable https://nixos.org/channels/nixpkgs-unstable
```

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixos-unstable
```

```bash
nix-channel --update
```

```bash
home-manager switch
```
