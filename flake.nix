{
  description = "tubowen’s dotfiles (one-shot install HM + activate)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems f;
      username = "moonshot";   # 你的用户名
    in
    {
      # 把每套 homeConfiguration 转成一个可运行的 package
      packages = forAllSystems (system:
        let
          hm = home-manager.lib.homeManagerConfiguration {
            inherit system;
            modules = [ ./home.nix ];
          };
        in
        {
          ${username} = hm.activationPackage;
        });

      # 再包一层脚本：先装 CLI，再激活
      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = toString (nixpkgs.legacyPackages.${system}.writeShellScript "install-and-switch" ''
            set -euo pipefail

            HM_PKG="${home-manager.packages.${system}.home-manager}"
            HM_BIN="$HM_PKG/bin/home-manager"

            # 永久安装 CLI
            nix profile install "$HM_PKG"

            # 激活 dotfiles
            "$HM_BIN" switch --flake ${self}
          '');
        };
      });
    };
}