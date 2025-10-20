#!/bin/bash
# Script to apply TWRP Samsung JDM Haptics patch before building recovery
# This should be called from BoardConfig.mk or AndroidProducts.mk

# Get the device tree directory (where this script lives)
DEVICE_TREE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PATCH_FILE="$DEVICE_TREE/Patches/TWRP-Samsung-JDM-Vibration.patch"

# Source root is 3 levels up from device tree
# device/samsung/a16xm -> ../../.. -> source root
SOURCE_ROOT="$(cd "$DEVICE_TREE/../../.." && pwd)"

# Lock file to prevent multiple simultaneous executions
LOCK_FILE="$SOURCE_ROOT/.jdm_patch_lock"
LOG_FILE="$DEVICE_TREE/jdm-patch.log"

# Check if lock exists (patch already applied in this build session)
if [[ -d "$LOCK_FILE" ]]; then
    exit 0
fi

# Create lock file
mkdir "$LOCK_FILE" 2>/dev/null || exit 0

set -e

# Redirect all output to log file
exec > "$LOG_FILE" 2>&1

echo "=== JDM Vibration Patch Application Log ==="
echo "Timestamp: $(date)"
echo "Device tree: $DEVICE_TREE"
echo "Source root: $SOURCE_ROOT"
echo "Patch file: $PATCH_FILE"
echo ""

# Validate paths
if [[ ! -d "$SOURCE_ROOT" ]]; then
    echo "ERROR: Source root not found at $SOURCE_ROOT"
    exit 1
fi

if [[ ! -f "$PATCH_FILE" ]]; then
    echo "ERROR: Patch file not found at $PATCH_FILE"
    exit 1
fi

# Change to source root
cd "$SOURCE_ROOT"

# Check if patch is already applied by looking for the marker
MARKER_FILE="bootable/recovery/minuitwrp/events.cpp"
if [[ -f "$MARKER_FILE" ]] && grep -q "#ifdef USE_SAMSUNG_JDM_HAPTICS" "$MARKER_FILE"; then
    echo "Patch already applied, skipping..."
    echo "Status: SUCCESS (already applied)"
    exit 0
fi

echo "Applying patch..."

# Apply the patch
if patch -p1 < "$PATCH_FILE"; then
    echo "Patch applied successfully!"
    echo "Status: SUCCESS"
    exit 0
else
    # Check if marker exists now (might have failed but was already applied)
    if [[ -f "$MARKER_FILE" ]] && grep -q "#ifdef USE_SAMSUNG_JDM_HAPTICS" "$MARKER_FILE"; then
        echo "Patch already applied (marker detected), skipping..."
        echo "Status: SUCCESS (already applied)"
        exit 0
    else
        echo "ERROR: Failed to apply patch"
        echo "Status: FAILED"
        exit 1
    fi
fi
