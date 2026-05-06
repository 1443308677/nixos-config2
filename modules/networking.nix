# ============================================
# 网络配置模块
# 配置网络连接、防火墙和时间同步
# ============================================

{ config, pkgs, ... }:

{
  # ------------------------------
  # 网络基础配置
  # ------------------------------
  networking.hostName = "nixos";                    # 主机名
  networking.networkmanager.enable = true;          # 启用 NetworkManager
  networking.firewall.enable = true;                # 启用防火墙

  # ------------------------------
  # 时间同步配置
  # ------------------------------
  services.timesyncd.enable = true;                 # 启用 systemd 时间同步服务
}
