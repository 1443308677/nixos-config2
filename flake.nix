# ============================================
# NixOS Flake 配置文件
# 作为整个系统配置的入口点，定义输入源和输出配置
# ============================================

{
  # Flake 描述信息
  description = "Kinos NixOS Configuration Flake";

  # ------------------------------
  # Nix 配置选项
  # ------------------------------
  nixConfig = {
    allowUnfree = true;  # 允许使用非自由软件包
  };

  # ------------------------------
  # 输入源定义
  # ------------------------------
  inputs = {
    # Nixpkgs 仓库 - 使用 unstable-small 分支（更小更快）
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";

    # Home Manager - 用户级配置管理工具
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";  # 跟随主 nixpkgs 输入
    };
  };

  # ------------------------------
  # 输出配置
  # ------------------------------
  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    # NixOS 系统配置
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";  # 目标系统架构
      specialArgs = { inherit inputs; };  # 将 inputs 传递给模块

      # 加载的配置模块列表
      modules = [
        # 主配置文件（导入所有模块）
        ./configuration.nix

        # 内联模块 - 安装 Niri 窗口管理器
        ({ pkgs, ... }: {
          environment.systemPackages = with pkgs; [
            pkgs.niri  # Niri 平铺窗口管理器
          ];
        })

        # Home Manager 集成配置
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;        # 使用系统级软件包
          home-manager.useUserPackages = true;      # 允许用户级软件包
          home-manager.users.kinos = import ./home/kinos/home.nix;  # kinos 用户配置
        }
      ];
    };
  };
}
