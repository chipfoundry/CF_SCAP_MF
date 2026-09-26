#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
OUT="${TMPDIR:-/tmp}/cf_scap_mf_tb"
iverilog -g2005 -o "$OUT" \
  "$ROOT/hdl/gl/CF_SCAP_MF.v" \
  "$ROOT/verify/beh_model/CF_SCAP_MF_core.v" \
  "$ROOT/verify/beh_model/tb_CF_SCAP_MF.v"
vvp "$OUT"
