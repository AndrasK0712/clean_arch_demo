#!/usr/bin/env sh
# Chứng minh Presentation/Domain không import từ tầng Data.
# Kết quả mong đợi: không in ra dòng nào + exit code 0.
set -u
cd "$(dirname "$0")/.."

echo "== Presentation -> Data (phải rỗng) =="
grep -rnE "^(import|export) .*(/data/|package:dio/)" lib/features/*/presentation && FAIL=1

echo "== Domain -> Data/Presentation/Flutter/Dio (phải rỗng) =="
grep -rnE "^(import|export) .*(/data/|/presentation/|package:flutter/|package:flutter_bloc/|package:dio/)" lib/features/*/domain && FAIL=1

if [ "${FAIL:-0}" = "1" ]; then
  echo "❌ Vi phạm Dependency Rule"; exit 1
fi
echo "✅ Không có vi phạm Dependency Rule"
