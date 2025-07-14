
#!/usr/bin/env bash
set -euo pipefail

# === 配置 ============================================================
C_PART=/dev/nvme0n1p3
D_PART=/dev/nvme0n1p4
MOUNT_C=/mnt/win-c
MOUNT_D=/mnt/win-d
FM=${FILE_MANAGER:-thunar}          # yazi / lf 等均可

DRIVER=ntfs3                        # 自动回退 ntfs-3g
OPTS="uid=$(id -u),gid=$(id -g),umask=022"
FUSE_OPTS="big_writes,$OPTS"

# === 工具函数 ========================================================
is_mounted()  { findmnt -nro TARGET "$1" &>/dev/null; }
color()       { printf '\e[%sm%s\e[0m\n' "$1" "$2"; }

mount_one() {                       # $1=设备 $2=挂载点
  sudo mkdir -p "$2"
  if sudo mount -t "$DRIVER" -o "$OPTS" "$1" "$2" 2>/dev/null ||
     sudo mount -t ntfs-3g -o "$FUSE_OPTS" "$1" "$2"; then
    color 32 "✓ $1 → $2"
    return 0
  else
    color 31 "✗ 挂载 $1 失败"
    return 1
  fi
}

umount_one() {                      # $1=挂载点
  if is_mounted "$1"; then
    if sudo umount "$1"; then
      color 32 "✓ 卸载 $1"
    else
      color 33 "⚠️ 无法卸载 $1（可能仍被占用）"
    fi
  fi
}

open_fm() { "$FM" "$MOUNT_C" "$MOUNT_D" & }

# === 主逻辑 ==========================================================
case "${1:-toggle}" in
  mount)
    success=false
    mount_one "$C_PART" "$MOUNT_C" && success=true
    mount_one "$D_PART" "$MOUNT_D" && success=true
    $success && open_fm
    ;;
  umount)
    umount_one "$MOUNT_C"
    umount_one "$MOUNT_D"
    ;;
  toggle)
    if is_mounted "$MOUNT_C" || is_mounted "$MOUNT_D"; then
      "$0" umount
    else
      "$0" mount
    fi
    ;;
  *)
    echo "用法: $0 [mount|umount|toggle]"
    exit 1
    ;;
esac

