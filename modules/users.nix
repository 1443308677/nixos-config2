# ============================================
# 用户配置模块
# 配置系统用户账户和权限
# ============================================

{ config, pkgs, ... }:

{
  # ------------------------------
  # 用户账户配置
  # ------------------------------
  users.users.kinos = {
    isNormalUser = true;              # 普通用户（非系统用户）
    description = "Kinos Li";         # 用户描述
    home = "/home/kinos";             # 用户主目录
    createHome = true;                # 自动创建主目录
    extraGroups = [
      "wheel"                         # 允许 sudo 权限
      "networkmanager"                # 允许管理网络
    ];
    shell = pkgs.fish;                # 默认 Shell 为 Fish
  };

  # ------------------------------
  # Fish Shell 配置
  # ------------------------------
  programs.fish.enable = true;        # 启用系统级 Fish Shell 配置
}
