# ============================================
# 桌面环境配置模块
# 配置图形界面、显示服务器、输入法和音频服务
# ============================================

{ config, pkgs, ... }:

{
  # ------------------------------
  # 图形服务器配置
  # ------------------------------
  services.xserver.enable = true;              # 启用 X Window 系统
  services.displayManager.gdm.enable = true;   # 启用 GDM 显示管理器
  services.displayManager.gdm.wayland = true;  # GDM 使用 Wayland 协议
  services.accounts-daemon.enable = true;      # 启用账户管理守护进程

  # ------------------------------
  # Niri 窗口管理器配置
  # ------------------------------
  services.xserver.windowManager.niri.enable = true;

  # ------------------------------
  # 音频系统配置
  # ------------------------------
  services.pulseaudio.enable = false;          # 禁用 PulseAudio（使用 PipeWire 替代）
  services.pipewire = {
    enable = true;                            # 启用 PipeWire 音频服务
    alsa.enable = true;                       # 启用 ALSA 兼容层
    alsa.support32Bit = true;                 # 支持 32 位应用
    pulse.enable = true;                      # 启用 PulseAudio 兼容层
  };

  # ------------------------------
  # 输入法配置
  # ------------------------------
  i18n.inputMethod = {
    type = "fcitx5";                          # 使用 Fcitx5 输入法框架
    fcitx5.addons = with pkgs; [
      fcitx5-rime                            # Rime 输入法引擎
      qt6Packages.fcitx5-chinese-addons       # Qt6 中文输入法组件
    ];
  };

  # ------------------------------
  # 附加服务配置
  # ------------------------------
  services.printing.enable = true;            # 启用打印服务
  virtualisation.vmware.guest.enable = true;  # 启用 VMware 虚拟机客户机工具

  # ------------------------------
  # 环境变量配置
  # ------------------------------
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";                    # 强制 Electron 应用使用 Wayland
    MOZ_ENABLE_WAYLAND = "1";                 # 强制 Firefox 使用 Wayland
  };
}
