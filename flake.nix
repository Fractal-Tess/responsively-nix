{
  description = "Responsively App - A responsive web design testing tool";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.responsively = pkgs.appimageTools.wrapType2 {
          pname = "Responsively";
          version = "1.15.0";

          src = pkgs.fetchurl {
            url = "https://github.com/responsively-org/responsively-app-releases/releases/download/v1.15.0/ResponsivelyApp-1.15.0.AppImage";
            sha256 = "06496363c225e3903625bb0b8106e3b310b2d259c566fb697391f3bc8d67c169";
          };

          extraInstallPhase = ''
            # Create application directories for .desktop file
            mkdir -p $out/share/applications
            mkdir -p $out/share/icons/hicolor/scalable/apps

            # Copy the desktop entry to the appropriate location
            cp ${pkgs.makeDesktopItem {
              name = "responsively";
              desktopName = "Responsively";
              comment = "Responsive Web Design Testing Tool";
              exec = "$out/bin/responsively";
              icon = "responsively";
              categories = [ "Development" "WebBrowser" ];
            }}/share/applications/* $out/share/applications/

            # Copy an icon if available (you can replace this with the actual path to an icon file)
            cp ${pkgs.fetchurl {
              url = "https://raw.githubusercontent.com/responsively-org/responsively-app/master/assets/icon.png";
              sha256 = "sha256-of-the-icon-file"; # Replace with actual sha256 of the icon
            }} $out/share/icons/hicolor/scalable/apps/responsively.png
          '';

          # Update desktop database during installation
          postInstall = ''
            if command -v update-desktop-database > /dev/null; then
              update-desktop-database $out/share/applications
            fi
          '';
        };

        overlay = final: prev: {
          responsively = self.packages.${system}.responsively;
        };
      }
    );
}
