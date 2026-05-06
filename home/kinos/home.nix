# ============================================
# Home Manager 用户配置文件
# 配置 kinos 用户的个人环境和应用程序设置
# ============================================

{ config, pkgs, lib, ... }:

{
  # ------------------------------
  # 基础配置
  # ------------------------------
  # 导入其他配置模块（当前为空）
  imports = [ ];

  # 用户基本信息
  home.username = "kinos";              # 用户名
  home.homeDirectory = "/home/kinos";   # 用户主目录路径
  home.stateVersion = "25.11";          # Home Manager 状态版本

  # Nixpkgs 配置
  nixpkgs = {
    config = {
      allowUnfree = true;               # 允许安装非自由软件包
    };
  };

  # 启用 Home Manager 自管理
  programs.home-manager.enable = true;

  # 系统服务配置
  systemd.user.startServices = "sd-switch";  # 使用 sd-switch 优雅重启服务

  # ------------------------------
  # 终端提示符配置 - Starship
  # ------------------------------
  programs.starship = {
    enable = true;                       # 启用 Starship 提示符
    enableFishIntegration = true;        # 启用 Fish Shell 集成
    settings = {
      add_newline = false;               # 不添加额外换行
      character = {
        success_symbol = "[➜](bold green)";  # 成功时的提示符符号
        error_symbol = "[➜](bold red)";      # 出错时的提示符符号
      };
      directory = {
        truncation_length = 3;           # 目录路径截断长度
        truncate_to_repo = true;         # 在仓库根目录截断
      };
      git_branch = {
        symbol = " ";                    # Git 分支符号
        format = "[$symbol$branch]($style) ";  # 分支显示格式
      };
      git_status = {
        format = "([$all_status$ahead_behind]($style) )";  # Git 状态显示格式
      };
    };
  };

  # ------------------------------
  # Git 版本控制配置
  # ------------------------------
  programs.git = {
    enable = true;                       # 启用 Git 配置
    userName = "1443308677";            # Git 用户名
    userEmail = "1443308677@qq.com";    # Git 邮箱
    extraConfig = {
      init.defaultBranch = "main";       # 默认分支名为 main
      core.editor = "hx";                # 默认编辑器为 Helix
      pull.rebase = true;                # Pull 时使用 rebase 模式
    };
  };

  # ------------------------------
  # Helix 编辑器配置
  # ------------------------------
  programs.helix = {
    enable = true;                       # 启用 Helix 配置
    settings = {
      editor = {
        line-number = "relative";        # 使用相对行号
        mouse = false;                   # 禁用鼠标支持
        cursor-shape = {
          normal = "block";              # 普通模式光标形状
          insert = "bar";                # 插入模式光标形状
          select = "underline";          # 选择模式光标形状
        };
        file-picker = {
          hidden = false;                # 文件选择器不显示隐藏文件
        };
      };
      keys.normal = {
        "C-s" = ":w";                   # Ctrl+S 保存文件
        "C-q" = ":q";                   # Ctrl+Q 退出编辑器
      };
    };
    languages.language = [
      {
        name = "nix";                    # Nix 语言配置
        auto-format = true;              # 自动格式化
        formatter.command = "${pkgs.nixfmt-classic}/bin/nixfmt";  # 使用 nixfmt 格式化
      }
    ];
  };

  # ------------------------------
  # Fish Shell 配置
  # ------------------------------
  programs.fish = {
    enable = true;                       # 启用 Fish Shell
    shellAbbrs = {
      ll = "ls -l";                     # 长列表格式
      la = "ls -a";                     # 显示隐藏文件
      ".." = "cd ..";                   # 返回上级目录
      "..." = "cd ../..";               # 返回上两级目录
      grep = "rg";                      # 使用 ripgrep 替代 grep
      find = "fd";                      # 使用 fd 替代 find
      cat = "bat";                      # 使用 bat 替代 cat
      ls = "eza";                       # 使用 eza 替代 ls
    };
  };

  # ------------------------------
  # Kitty 终端配置
  # ------------------------------
  programs.kitty = {
    enable = true;                       # 启用 Kitty 终端
    settings = {
      font_family = "JetBrainsMono Nerd Font";  # 字体家族
      font_size = 12;                    # 字体大小
      background_opacity = "0.9";        # 背景透明度
      confirm_os_window_close = 0;       # 关闭窗口时不确认
      enable_audio_bell = false;         # 禁用声音提示
      window_padding_width = 10;         # 窗口内边距
      tab_bar_edge = "bottom";           # 标签栏位置在底部
      tab_bar_style = "powerline";       # 标签栏样式
      tab_powerline_style = "slanted";   # Powerline 样式为斜角
    };
    theme = "Catppuccin-Mocha";          # 使用 Catppuccin Mocha 主题
  };

  # ------------------------------
  # Waybar 状态栏配置
  # ------------------------------
  programs.waybar = {
    enable = true;                       # 启用 Waybar 状态栏
    settings = {
      mainBar = {
        layer = "top";                   # 状态栏层级
        position = "top";                # 状态栏位置
        height = 30;                     # 状态栏高度
        modules-left = [ "niri/workspaces" "niri/window" ];   # 左侧模块
        modules-center = [ "clock" ];    # 中间模块
        modules-right = [ "battery" "network" "pulseaudio" "tray" ];  # 右侧模块

        # Niri 工作区模块
        "niri/workspaces" = {
          format = "{index}";            # 显示工作区索引
        };

        # Niri 窗口标题模块
        "niri/window" = {
          format = "{}";                 # 显示窗口标题
          max-length = 50;               # 最大长度限制
        };

        # 时钟模块
        clock = {
          format = "{:%H:%M} ";          # 时间格式（小时:分钟）
          format-alt = "{:%Y-%m-%d}";    # 悬停时显示日期
        };

        # 电池模块
        battery = {
          format = "{capacity}% {icon}"; # 显示电量百分比
          format-icons = [ "" "" "" "" "" ];  # 电池图标（空表示使用默认）
        };

        # 网络模块
        network = {
          format-wifi = "{essid} ({signalStrength}%) ";   # WiFi 格式
          format-ethernet = "{ipaddr} ";                   # 有线网络格式
          format-disconnected = "Disconnected ⚠";          # 断开连接提示
        };

        # 音频模块
        pulseaudio = {
          format = "{volume}% {icon}";   # 音量显示格式
          format-muted = " muted";       # 静音提示
          format-icons = {
            default = [ "" "" "" ];      # 音量图标
          };
        };

        # 系统托盘模块
        tray = {
          spacing = 10;                  # 图标间距
        };
      };
    };
    style = ''
      /* Waybar CSS 样式 */
      * {
        border: none;
        border-radius: 0;
        font-family: "Noto Sans CJK SC", "Font Awesome 6 Free";
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(30, 30, 46, 0.8);  /* 半透明背景 */
        color: #cdd6f4;                      /* 文字颜色 */
      }

      #workspaces button {
        padding: 0 5px;
        background-color: transparent;
        color: #cdd6f4;
      }

      #workspaces button.active {
        background-color: #89b4fa;           /* 活动工作区背景 */
        color: #1e1e2e;                      /* 活动工作区文字 */
      }

      #clock, #battery, #network, #pulseaudio, #tray {
        padding: 0 10px;
        margin: 0 4px;
      }

      #battery.charging {
        color: #a6e3a1;                      /* 充电时颜色 */
      }
    '';
  };

  # ------------------------------
  # 用户服务配置
  # ------------------------------
  services = {
    # 空闲管理服务（自动锁屏）
    swayidle = {
      enable = true;
      events = {
        lock = "${pkgs.swaylock}/bin/swaylock -c '#1e1e2e'";
        before-sleep = "${pkgs.swaylock}/bin/swaylock -c '#1e1e2e'";
        after-resume = "${pkgs.swaylock}/bin/swaylock -c '#1e1e2e'";
      };
    };

    # Polkit GNOME 权限管理
    polkit-gnome.enable = true;

    # Mako 通知守护进程
    mako.enable = true;
  };

  # ------------------------------
  # 用户软件包列表
  # ------------------------------
  home.packages = with pkgs; [
    btop            # 系统资源监控工具
    yazi            # 终端文件管理器
    ripgrep         # 快速文本搜索工具
    fd              # 快速文件查找工具
    bat             # 带语法高亮的 cat 替代
    eza             # 带颜色的 ls 替代
    fuzzel          # Wayland 应用启动器
    mako            # Wayland 通知守护进程
    grim            # Wayland 截图工具
    slurp           # 区域选择工具（配合 grim）
    swaybg          # 壁纸设置工具
    swaylock        # 锁屏工具
    wl-clipboard    # Wayland 剪贴板工具
    brightnessctl   # 亮度控制工具
    jetbrains-mono  # JetBrains Mono 字体
    nerd-fonts.jetbrains-mono  # JetBrains Mono Nerd Font
  ];

  # ------------------------------
  # 激活脚本
  # ------------------------------
  home.activation.downloadWallpaper = lib.hm.dag.entryAfter ["writeBoundary"] ''
    # 创建 Niri 配置目录
    mkdir -p $HOME/.config/niri
    # 如果壁纸文件不存在则下载
    if [ ! -f $HOME/.config/niri/wallpaper.jpg ]; then
      $DRY_RUN_CMD ${pkgs.curl}/bin/curl -L -o $HOME/.config/niri/wallpaper.jpg \
        "https://w.wallhaven.cc/full/8g/wallhaven-8g1o73.jpg" || true
    fi
  '';

  # ------------------------------
  # XDG 配置文件
  # ------------------------------

  # Niri 窗口管理器配置
  xdg.configFile."niri/config.kdl".text = ''
    // Mod 键定义（Super 键即 Windows 键）
    modifier "Mod" = "Super";

    // 输入设备配置
    input {
        keyboard {
            xkb {
                layout "us"              // 美式键盘布局
            }
        }

        touchpad {
            tap true                    // 启用触摸点击
            dwt true                    // 禁用触摸板时打字
            natural-scroll true         // 自然滚动方向
        }
    }

    // 窗口规则
    window-rule {
        match app-id="firefox"
        open-on-workspace "web"         // Firefox 自动打开到 web 工作区
    }

    // 启动应用（登录时自动启动）
    spawn-at-startup "waybar"           // 状态栏
    spawn-at-startup "mako"             // 通知
    spawn-at-startup "swaybg" "-i" "/home/kinos/.config/niri/wallpaper.jpg"  // 壁纸

    // 快捷键绑定
    binds {
        // 窗口管理
        Mod+Q { close-window; }                  // 关闭窗口
        Mod+Left { focus-column-left; }          // 聚焦左列
        Mod+Right { focus-column-right; }        // 聚焦右列
        Mod+Up { focus-window-up; }              // 聚焦上方窗口
        Mod+Down { focus-window-down; }          // 聚焦下方窗口
        Mod+Shift+Left { move-column-left; }     // 移动窗口到左列
        Mod+Shift+Right { move-column-right; }   // 移动窗口到右列
        Mod+F { fullscreen-window; }             // 全屏窗口

        // 工作区切换（1-9）
        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }

        // 移动窗口到工作区
        Mod+Shift+1 { move-window-to-workspace 1; }
        Mod+Shift+2 { move-window-to-workspace 2; }
        Mod+Shift+3 { move-window-to-workspace 3; }
        Mod+Shift+4 { move-window-to-workspace 4; }
        Mod+Shift+5 { move-window-to-workspace 5; }

        // 应用启动
        Mod+D { spawn "fuzzel"; }                // 打开应用启动器
        Mod+Return { spawn "kitty"; }            // 打开终端
        Mod+Print { spawn "sh" "-c" "grim -g \"$(slurp)\" - | wl-copy"; }  // 截图到剪贴板

        // 音量控制
        XF86AudioRaiseVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"; }  // 音量+
        XF86AudioLowerVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"; }  // 音量-
        XF86AudioMute { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }        // 静音切换

        // 亮度控制
        XF86MonBrightnessUp { spawn "brightnessctl" "set" "+5%"; }   // 亮度+5%
        XF86MonBrightnessDown { spawn "brightnessctl" "set" "5%-"; }  // 亮度-5%

        // 退出 Niri
        Mod+Shift+E { quit; }                    // 退出窗口管理器
    }
  '';

  # Fuzzel 应用启动器配置
  xdg.configFile."fuzzel/fuzzel.ini".text = ''
    [main]
    font=Noto Sans CJK SC:size=12        # 字体设置
    background=1e1e2eee                  # 背景颜色（含透明度）
    text-color=cdd6f4                    # 文字颜色
    prompt="➜ "                          # 提示符
    lines=5                              # 显示行数
    width=40                             # 宽度百分比
  '';

  # Mako 通知配置
  xdg.configFile."mako/config".text = ''
    font=Noto Sans CJK SC 12             # 字体设置
    background-color=#1e1e2e             # 背景颜色
    text-color=#cdd6f4                   # 文字颜色
    border-color=#89b4fa                 # 边框颜色
    border-size=2                        # 边框宽度
    default-timeout=5000                 # 默认超时时间（毫秒）
  '';
}
