# Include GSM stuff
$(call inherit-product, vendor/cm/config/gsm.mk)

# Release name and versioning
PRODUCT_RELEASE_NAME := totoro

# Prepare for new BootAnimation
TARGET_BOOTANIMATION_NAME := vertical-240x320

# Inherit some common cyanogenmod stuff.
$(call inherit-product, vendor/cm/config/common_mini_phone.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/totoro/full_totoro.mk)

# Device identifier. This must come after all inclusions
PRODUCT_NAME := cm_totoro
PRODUCT_BRAND := samsung
PRODUCT_DEVICE := totoro
PRODUCT_MODEL := GT-S5360
PRODUCT_MANUFACTURER := samsung

# Set build fingerprint / ID / Product Name etc.
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=totoro TARGET_DEVICE=totoro
