# ============================================
# Nix 配置模块
# 配置 Nix 包管理器的行为和垃圾回收
# ============================================

{ config, pkgs, ... }:

{
  # ------------------------------
  # Nix 守护进程配置
  # ------------------------------
  nix = {
    # 垃圾回收配置
    gc = {
      automatic = true;                    # 启用自动垃圾回收
      dates = "weekly";                    # 每周执行一次
      options = "--delete-older-than 7d";  # 删除7天前的旧代次
      randomizedDelaySec = "1h";           # 随机延迟最多1小时
    };

    # 优化设置
    settings = {
      # 最大并发构建作业数（建议为 CPU 核心数）
      max-jobs = "auto";
      
      # 构建日志大小限制
      log-lines = 10000;
      
      # 允许使用非自由软件包（系统级）
      allow-unfree = true;
      
      # 启用实验性功能
      experimental-features = [ "nix-command" "flakes" ];

      # 二进制缓存配置
      substituters = [
        "https://cache.nixos.org"
      ];

      # 允许预构建的二进制缓存签名
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
    };
  };
}
