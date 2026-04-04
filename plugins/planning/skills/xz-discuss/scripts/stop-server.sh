#!/bin/bash
# 停止可视化服务并清理
# 用法: stop-server.sh <screen_dir>
#
# 终止服务进程。仅删除 /tmp 下的临时会话目录。
# 项目目录下的 .xz_planning/visual/ 会保留，方便后续查阅。

SCREEN_DIR="$1"

if [[ -z "$SCREEN_DIR" ]]; then
  echo '{"error": "Usage: stop-server.sh <screen_dir>"}'
  exit 1
fi

PID_FILE="${SCREEN_DIR}/.server.pid"

if [[ -f "$PID_FILE" ]]; then
  pid=$(cat "$PID_FILE")
  kill "$pid" 2>/dev/null
  rm -f "$PID_FILE" "${SCREEN_DIR}/.server.log"

  # 仅删除 /tmp 下的临时目录
  if [[ "$SCREEN_DIR" == /tmp/* ]]; then
    rm -rf "$SCREEN_DIR"
  fi

  echo '{"status": "stopped"}'
else
  echo '{"status": "not_running"}'
fi
