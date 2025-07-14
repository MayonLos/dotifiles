# 快捷键绑定
config.bind('J', 'tab-prev')               # 切换到前一个标签页
config.bind('K', 'tab-next')               # 切换到后一个标签页
config.bind('H', 'back')                   # 后退
config.bind('L', 'forward')                # 前进
config.bind('xx', 'tab-close')             # 关闭标签页
config.bind('<Ctrl-q>', 'quit')            # 退出
config.bind('<Ctrl-y>', 'yank')            # ✅ 复制当前链接
config.bind(',h', 'config-source')         # 重新加载配置
config.bind(',j', 'config-cycle content.javascript.enabled')  # 切 JS
config.bind(',i', 'config-cycle content.images true false')   # 切图像
# 快捷键：启用 SOCKS5 代理
config.bind(',p', 'set content.proxy socks5://127.0.0.1:7897', mode='normal')

# 快捷键：切换回直连（关闭代理）
config.bind(',o', 'set content.proxy system', mode='normal')

# 可选：显示当前代理状态（回显在状态栏）
config.bind(',s', 'message-info "当前代理: {content.proxy}"', mode='normal')

# 快捷键：切换网页暗色模式（暗 / 亮）
config.bind(',d', 'config-cycle colors.webpage.darkmode.enabled')

