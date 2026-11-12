{
  description = "BuryOS Hyprland configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = {
    self,
    nixpkgs,
    hyprland,
    hyprland-plugins,
    ... }: {

    # NixOS module (system-level package config)
    nixosModules.default = { pkgs, ... }: {
      programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
        package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      };
    };

    # Home-manager support (HOME configs)
    homeManagerModules.default = { pkgs, ... }: {
      # Bind the configuration files
      xdg.configFile."hypr" = {
        source = ./src;
        recursive = true;
      };
    };
  };
}
