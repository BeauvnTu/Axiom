{
  description = "My NixOS/flake config with home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

 outputs = { self, nixpkgs, home-manager }:
    let
      system = "aarch64-darwin";  # 根据你的系统修改
      pkgs = nixpkgs.legacyPackages.${system};
      username = "Bowen Tu";
    in
    {
      # 💡 定义你的 home-manager 配置
      homeConfigurations.syourl = home-manager.lib.homeConfiguration {
        username = username;
        homeDirectory = "/home/${username}";
        configuration = {
          imports = [ ./home.nix ];
        };
      };

      # ✅ 关键：定义 devShell，让 nix develop 可用
      devShells.${system}.default = pkgs.mkShell {
        # 把 home-manager 命令加进来
        buildInputs = [
          home-manager.packages.${system}.home-manager
        ];
      };
    };
}