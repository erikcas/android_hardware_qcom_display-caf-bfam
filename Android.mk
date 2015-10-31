ifeq ($(TARGET_QCOM_DISPLAY_VARIANT),caf-msm8994)
# This flag will be set to true during migration to Snapdragon Display Engine.
TARGET_USES_SDE = false

display-hals := libgralloc libcopybit liblight libmemtrack libqservice libqdutils

ifeq ($(TARGET_USES_SDE), true)
    sde-libs := displayengine/libs
    display-hals += $(sde-libs)/utils $(sde-libs)/core $(sde-libs)/hwc
else
    display-hals += libgenlock libhwcomposer liboverlay libhdmi
endif

ifeq ($(call is-vendor-board-platform,QCOM),true)
    include $(call all-named-subdir-makefiles,$(display-hals))
else
ifneq ($(filter msm8960,$(TARGET_BOARD_PLATFORM)),)
    include $(call all-named-subdir-makefiles,$(display-hals))
endif
endif
endif
