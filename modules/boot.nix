# ============================================
# 系统启动配置模块
# 配置 bootloader 和内核相关选项
# ============================================

{ config, pkgs, ... }:

{
  # ------------------------------
  # Bootloader 配置
  # ------------------------------
  boot.loader.systemd-boot.enable = true;       # 启用 systemd-boot 引导程序
  boot.loader.efi.canTouchEfiVariables = true;  # 允许修改 EFI 变量

  # ------------------------------
  # 内核配置
  # ------------------------------
  boot.kernelPackages = pkgs.linuxPackages_latest;  # 使用最新稳定内核
}
