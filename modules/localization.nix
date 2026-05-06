# ============================================
# 本地化配置模块
# 配置时区、语言和控制台字体
# ============================================

{ config, pkgs, ... }:

{
  # ------------------------------
  # 时区配置
  # ------------------------------
  time.timeZone = "Asia/Shanghai";  # 设置时区为上海

  # ------------------------------
  # 语言环境配置
  # ------------------------------
  i18n.defaultLocale = "zh_CN.UTF-8";  # 默认语言环境为中文 UTF-8
  i18n.extraLocaleSettings = {
    LC_TIME = "zh_CN.UTF-8";       # 时间格式
    LC_MONETARY = "zh_CN.UTF-8";   # 货币格式
    LC_PAPER = "zh_CN.UTF-8";      # 纸张格式
    LC_MEASUREMENT = "zh_CN.UTF-8"; # 度量单位
  };

  # ------------------------------
  # 控制台字体配置
  # ------------------------------
  console.font = "ter-u28n";                # 使用 Terminus 字体（28pt）
  console.packages = [ pkgs.terminus_font ]; # 安装 Terminus 字体包
}
