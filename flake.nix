{
  description = "Responsively App - A responsive web design testing tool";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.responsively = pkgs.appimageTools.wrapType2 {
          name = "ResponsivelyApp";
          version = "1.15.0";

          src = pkgs.fetchurl {
            url = "https://github.com/responsively-org/responsively-app-releases/releases/download/v1.15.0/ResponsivelyApp-1.15.0.AppImage";
            sha256 = "06496363c225e3903625bb0b8106e3b310b2d259c566fb697391f3bc8d67c169";
          };

          extraInstallPhase = ''
            mkdir -p $out/share/applications
            cp ${pkgs.makeDesktopItem {
              name = "responsively";
              desktopName = "Responsively";
              comment = "Responsive Web Design Testing Tool";
              exec = "$out/bin/ResponsivelyApp";
              icon = "responsively";
              categories = [ "Development" "WebBrowser" ];
            }}/share/applications/* $out/share/applications/
          '';
        };

        defaultPackage = self.packages.${system}.responsively;
      }
    );
}
