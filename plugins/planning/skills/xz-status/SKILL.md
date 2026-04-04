---
name: xz-status
description: 查看当前所有版本的计划状态总览。/xz-status
disable-model-invocation: true
---

# XZ Status - 查看计划状态

## 辅助脚本

**脚本路径**：取本 skill 的 Base directory（prompt 开头 "Base directory for this skill:" 的值），向上两级目录，拼接 `bin/xz-tools.py`。

示例：Base directory = `.../skills/xz-status` → 脚本 = `.../bin/xz-tools.py`

后续所有调用使用 `python3 <脚本绝对路径> <命令>` 格式。脚本在**当前工作目录**下操作 `.xz_planning/`。

---

## 执行流程

### 第一步：获取状态

```bash
python3 <脚本绝对路径> status
```

### 第二步：格式化输出

根据返回的 JSON 数据，输出可视化状态：

```
XZ Planning Status

🚧 活跃版本:
  [1] 用户注册登录    ███░░░ 2/4 (50%)
  [2] 商品管理模块    ░░░░░░ 0/3 (0%)

✅ 已归档:
  [0] 项目初始化      4/4 (100%)  2026-03-12

💡 下一步: /xz-exec 1
```

如果 `.xz_planning` 不存在，提示：

```
XZ Planning 未初始化。运行 /xz-plan N 需求描述 开始第一个计划。
```

### 第三步：读取 STATE.md

同时读取并展示 `.xz_planning/STATE.md` 的完整内容，让用户看到表格形式的状态。

## 输出规则

1. **进度条可视化** — 用 █ 和 ░ 表示完成比例
2. **给出下一步建议** — 如有进行中的版本，建议 `/xz-exec N`
3. **同时展示 STATE.md** — 表格和可视化两种形式都展示
