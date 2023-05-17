#
# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Omni stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from a14xm device
$(call inherit-product, device/samsung/a14xm/device.mk)

PRODUCT_DEVICE := a14xm
PRODUCT_NAME := twrp_a14xm
PRODUCT_BRAND := samsung
PRODUCT_MODEL := SM-A146P
PRODUCT_MANUFACTURER := samsung

PRODUCT_GMS_CLIENTID_BASE := android-samsung

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="a14xmxx-user 12 SP1A.210812.016 A146PXXU1AWB5 release-keys"

BUILD_FINGERPRINT := samsung/a14xmxx/a14xm:12/SP1A.210812.016/A146PXXU1AWB5:user/release-keys
