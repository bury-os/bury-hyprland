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
        # Enable Hyprland cache
        nix.settings = {
          substituters = [
            "https://hyprland.cachix.org"
          ];
          trusted-substituters = [
            "https://hyprland.cachix.org"
          ];
          trusted-public-keys = [
            "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          ];
        };

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

      # Packages used in various plugins and modules (launcher, screenshots, etc)
      home.packages = with pkgs; [
        rofi
        wlogout
        hyprshot
      ];
    };
  };
}
