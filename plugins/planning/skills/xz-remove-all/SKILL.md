---
name: xz-remove-all
description: 交互式清理整个 .xz_planning 目录。/xz-remove-all
disable-model-invocation: true
---

# XZ Remove All - 清理全部计划数据

## 辅助脚本

插件 `bin/` 目录下的 `xz-tools.py`（插件启用时自动加入 PATH）

脚本在**当前工作目录**下操作 `.xz_planning/`。

---

## 执行流程

### 第一步：运行交互式菜单

```bash
xz-tools.py remove-all
```

脚本会显示交互式终端菜单：

- **↑↓ 方向键**：在「全部删除」和「否」之间切换
- **Enter**：确认当前选择
- **Tab**：切换到自定义输入框，可输入如 "只删除 archive"、"保留 1 删除 2" 等自然语言

### 第二步：处理结果

脚本返回 JSON，根据 `action` 字段处理：

- `action: "remove_all"` → 已删除整个 .xz_planning，输出确认
- `action: "cancel"` → 用户取消，不做操作
- `action: "custom"` → 读取 `input` 字段的自然语言要求，解析并执行对应操作：
  - 解析用户意图（如 "只删 archive"、"删除版本 2"）
  - 执行对应的文件删除操作
  - 更新 STATE.md
- `mode: "non-interactive"` → 非终端环境，展示当前内容，询问用户要如何处理

### 第三步：输出结果

展示操作结果，说明删除了什么、保留了什么。

## 关键规则

1. **必须先确认** — 任何删除操作都需要用户明确选择
2. **自定义输入灵活处理** — Tab 切换后用户可以用自然语言描述删除范围
3. **全部删除是 rm 整个 .xz_planning** — 包括 STATE.md、所有 phases、archive
