# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Add device package overlay
DEVICE_PACKAGE_OVERLAYS := device/samsung/totoro/overlay

# The device is LDPI
PRODUCT_AAPT_CONFIG := normal mdpi ldpi
PRODUCT_AAPT_PREF_CONFIG := ldpi

# RIL properties
PRODUCT_PROPERTY_OVERRIDES += \
    rild.libargs=-d/dev/smd0 \
    rild.libpath=/system/lib/libbrcm_ril.so \
    ro.telephony.ril_class=SamsungRIL \
    mobiledata.interfaces=pdp0,eth0,gprs,ppp0 \
    ro.ril.hsxpa=1 \
    ro.ril.gprsclass=10 \

# Board-specific init
PRODUCT_COPY_FILES += \
    device/samsung/totoro/prebuilt/root/ueventd.gt-s5360.rc:root/ueventd.gt-s5360.rc \
    device/samsung/totoro/prebuilt/root/init.gt-s5360.rc:root/init.gt-s5360.rc

# Filesystem management tools
PRODUCT_PACKAGES += \
    static_busybox \
    make_ext4fs \
    setup_fs
    
# Device Specific
PRODUCT_PACKAGES += \
    libstagefrighthw \
    libopencorehw \
    libmm-omxcore \
    libOmxCore \
    gralloc.totoro \
    audio.a2dp.default \
    audio.usb.default \
    com.android.future.usb.accessory \
    libaudioutils \
    libtinyalsa \
    Torch
    
  
# These are the hardware-specific features
PRODUCT_COPY_FILES += \
        frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
        frameworks/base/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
        frameworks/base/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
	frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
	frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	frameworks/base/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
	frameworks/base/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
	frameworks/base/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
        frameworks/base/data/etc/android.hardware.touchscreen.xml:system/etc/permissions/android.hardware.touchscreen.xml \
	frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	frameworks/base/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/base/data/etc/android.software.sip.xml:system/etc/permissions/android.software.sip.xml \
        frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
	packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml

#kernel modules
PRODUCT_COPY_FILES += \
    device/samsung/totoro/prebuilt/root/fsr.ko:root/fsr.ko \
    device/samsung/totoro/prebuilt/root/fsr_stl.ko:root/fsr_stl.ko \
    device/samsung/totoro/prebuilt/root/rfs_fat.ko:root/rfs_fat.ko \
    device/samsung/totoro/prebuilt/root/rfs_glue.ko:root/rfs_glue.ko \
    device/samsung/totoro/prebuilt/root/j4fs.ko:root/j4fs.ko \
    device/samsung/totoro/prebuilt/root/sec_param.ko:root/sec_param.ko \


# Audio
#PRODUCT_PACKAGES += \
#	audio.primary.totoro

# Touchscreen
PRODUCT_COPY_FILES += \
    device/samsung/totoro/prebuilt/usr/idc/sec_touchscreen.idc:system/usr/idc/sec_touchscreen.idc

$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/firmware/bcm4330/device-bcm.mk)

# Media profiles
PRODUCT_COPY_FILES += \
    device/samsung/totoro/prebuilt/etc/media_profiles.xml:/system/etc/media_profiles.xml

# Wifi
PRODUCT_COPY_FILES += \
device/samsung/totoro/prebuilt/bin/get_macaddrs:/system/bin/get_macaddrs \

# Performance & graphics properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=131072 \
    ro.sf.lcd_density=120 \

$(call inherit-product, frameworks/native/build/phone-hdpi-512-dalvik-heap.mk)

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# other kernel modules not in ramdisk
ifeq ($(TARGET_PREBUILT_KERNEL),)
    LOCAL_KERNEL := device/samsung/totoro/kernel
else
    LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# NEW ICS properties (may need verification/testing)
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mass_storage,adb

$(call inherit-product, device/common/gps/gps_eu_supl.mk)

# Use the non-open-source parts, if they're present
include vendor/samsung/totoro/totoro-vendor.mk
