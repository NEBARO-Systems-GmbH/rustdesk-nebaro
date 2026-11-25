#!/usr/bin/env bash
# =====================================================================
# Applies the NEBARO patches to a checkout of rustdesk/rustdesk.
#
#   apply-patches.sh <rustdesk-checkout>
#
# The checkout must be at RUSTDESK_COMMIT (including the submodule libs/hbb_common).
# Patches with "hbb_common" in their name apply to the submodule, all others to the main repository.
# All patches are checked first; if one does not apply, nothing is changed.
# =====================================================================
set -euo pipefail

src="${1:?path to the RustDesk checkout is missing}"
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
commit="$(tr -d '[:space:]' < "$here/RUSTDESK_COMMIT")"

head="$(git -C "$src" rev-parse HEAD)"
if [ "$head" != "$commit" ]; then
  echo "error: checkout is at $head, pinned commit is $commit (RUSTDESK_COMMIT)."
  exit 1
fi

main=()
sub=()
for p in "$here"/patches/*.patch; do
  case "$(basename "$p")" in
    *hbb_common*) sub+=("$p") ;;
    *) main+=("$p") ;;
  esac
done

for p in "${main[@]}"; do git -C "$src" apply --check "$p"; done
for p in "${sub[@]}"; do git -C "$src/libs/hbb_common" apply --check "$p"; done
for p in "${main[@]}"; do git -C "$src" apply "$p"; echo "applied: $(basename "$p")"; done
for p in "${sub[@]}"; do git -C "$src/libs/hbb_common" apply "$p"; echo "applied: $(basename "$p") (libs/hbb_common)"; done
