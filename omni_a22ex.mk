#
# Copyright (C) 2022 The Android Open Source Project
# Copyright (C) 2022 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Omni stuff.
$(call inherit-product, vendor/omni/config/common.mk)

# Inherit from a22ex device
$(call inherit-product, device/samsung/a22ex/device.mk)

PRODUCT_DEVICE := a22ex
PRODUCT_NAME := omni_a22ex
PRODUCT_BRAND := samsung
PRODUCT_MODEL := SC-56B
PRODUCT_MANUFACTURER := samsung

PRODUCT_GMS_CLIENTID_BASE := android-samsung-ss

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="a22exdcm-user 12 SP1A.210812.016 SC56BOMU1BVI2 release-keys"

BUILD_FINGERPRINT := samsung/SC-56B/SC-56B:12/SP1A.210812.016/SC56BOMU1BVI2:user/release-keys
