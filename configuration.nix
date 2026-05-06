# ============================================
# NixOS 主配置文件
# 作为系统配置的入口，导入所有功能模块
# ============================================

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix  # 硬件配置（必须放在最后，以便覆盖其他配置）
    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/localization.nix
    ./modules/desktop.nix
    ./modules/users.nix
    ./modules/packages.nix
    ./modules/nix.nix        # Nix 配置模块（新增）
  ];

  # 系统状态版本（必须与 NixOS 版本匹配）
  system.stateVersion = "25.11";
}
