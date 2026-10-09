TARGET := iphone:clang:7.0:6.0
INSTALL_TARGET_PROCESSES = itunesstored AppStore MobileStore Podcasts iBooks iTunesU


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NewerStoreLoginFix

NewerStoreLoginFix_FILES = Tweak.x
NewerStoreLoginFix_CFLAGS = -fobjc-arc -Wno-gcc-compat -isystem /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/6.0/include/

include $(THEOS_MAKE_PATH)/tweak.mk
