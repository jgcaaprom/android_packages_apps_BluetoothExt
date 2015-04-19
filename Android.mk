ifeq ($(BOARD_HAVE_BLUETOOTH_QCOM),true)

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional
src_dirs:= src/org/codeaurora/bluetooth/btcservice \
           src/org/codeaurora/bluetooth/ftp \
           src/org/codeaurora/bluetooth/dun \
           src/org/codeaurora/bluetooth/sap \
           src/org/codeaurora/bluetooth/pxpservice

ifeq ($(BOARD_USES_WIPOWER),true)
           src_dirs += src/org/codeaurora/bluetooth/a4wp
endif

LOCAL_CC  := $$(TARGET_TOOLCHAIN_ROOT)/../arm-linux-androideabi-4.8/bin/arm-linux-androideabi-gcc$$(HOST_EXECUTABLE_SUFFIX)
LOCAL_CXX := $$(TARGET_TOOLCHAIN_ROOT)/../arm-linux-androideabi-4.8/bin/arm-linux-androideabi-g++$$(HOST_EXECUTABLE_SUFFIX)

LOCAL_SRC_FILES := \
        $(call all-java-files-under, $(src_dirs)) \
        src/org/codeaurora/bluetooth/pxpservice/IPxpService.aidl

LOCAL_PACKAGE_NAME := BluetoothExt
LOCAL_CERTIFICATE := platform
LOCAL_JAVA_LIBRARIES := javax.obex
LOCAL_JAVA_LIBRARIES += mms-common
LOCAL_JAVA_LIBRARIES += telephony-common
ifeq ($(BOARD_USES_WIPOWER),true)
LOCAL_JAVA_LIBRARIES += com.quicinc.wbc
endif

LOCAL_STATIC_JAVA_LIBRARIES := com.android.vcard

LOCAL_REQUIRED_MODULES := bluetooth.default

LOCAL_PROGUARD_ENABLED := disabled

LOCAL_MULTILIB := 32
LOCAL_JNI_SHARED_LIBRARIES := libbluetooth_jni

include $(BUILD_PACKAGE)


include $(call all-makefiles-under,$(LOCAL_PATH))

endif
