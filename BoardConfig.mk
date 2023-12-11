#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Include the common OEM chipset BoardConfig.
include device/transsion/mt6789-common/BoardConfigCommon.mk

DEVICE_PATH := device/tecno/LH7n
DEVICE_KERNEL := $(DEVICE_PATH)-kernel

# DTB
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_KERNEL)/dtbo.img
BOARD_PREBUILT_DTBIMAGE_DIR := $(DEVICE_KERNEL)/dtb

# Kernel modules
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_KERNEL)/modules.load.vendor_ramdisk))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(addprefix $(DEVICE_KERNEL)/modules/, $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD))

# Also add recovery modules to vendor ramdisk
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_KERNEL)/modules.load.recovery))
RECOVERY_MODULES := $(addprefix $(DEVICE_KERNEL)/modules/, $(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD))

# Prevent duplicated entries (to solve duplicated build rules problem)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(sort $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES) $(RECOVERY_MODULES))

# Vendor modules (installed to vendor_dlkm)
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_KERNEL)/modules.load))
BOARD_VENDOR_KERNEL_MODULES := $(wildcard $(DEVICE_KERNEL)/modules/*.ko)

# Inherit the proprietary files
include vendor/tecno/LH7n/BoardConfigVendor.mk
