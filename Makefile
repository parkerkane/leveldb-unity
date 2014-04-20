
NDK=../../sdks/android-ndk-r9d/

UNITYPACKAGE=$(BUILDPATH)/unitypackage
ASSETS=$(UNITYPACKAGE)/Assets
PLUGINS=$(ASSETS)/Plugins
LEVELDB_ASSETS=$(ASSETS)/leveldb

ANDROID_PLUGINS=$(PLUGINS)/Android
IOS_PLUGINS=$(PLUGINS)/iOS

UNITYPACKAGE_BINARY=$(BUILDPATH)/leveldb.unitypackage

UNITY_OSX=/Applications/Unity/Unity.app/Contents/MacOS/Unity

BUILDPATH=$(shell pwd)/build
TOOLCHAIN=$(BUILDPATH)/toolchain

ANDROID_CC=$(TOOLCHAIN)/bin/arm-linux-androideabi-gcc
ANDROID_CXX=$(TOOLCHAIN)/bin/arm-linux-androideabi-g++
ANDROID_SETTINGS=CC=$(ANDROID_CC) CXX=$(ANDROID_CXX) TARGET_OS=OS_ANDROID_CROSSCOMPILE

IOS_SETTINGS=TARGET_OS=IOS

POSIX_SHARED=libleveldb.so
LIBRARY_NAME=libleveldb.a

LEVELDB_SRC=3rdparty/leveldb

all: 3rdparty android ios $(LEVELDB_ASSETS) $(UNITYPACKAGE_BINARY)

3rdparty:
	git submodule update

$(BUILDPATH):
	mkdir -p $(BUILDPATH)

$(TOOLCHAIN): $(BUILDPATH)
	mkdir -p $(TOOLCHAIN)
	$(NDK)/build/tools/make-standalone-toolchain.sh --platform=android-9 --install-dir=$(TOOLCHAIN)

$(ANDROID_PLUGINS)/$(POSIX_SHARED): $(TOOLCHAIN)
	mkdir -p $(ANDROID_PLUGINS)

	(cd $(LEVELDB_SRC) && $(ANDROID_SETTINGS) make -j8)

	cp $(LEVELDB_SRC)/$(POSIX_SHARED) $(ANDROID_PLUGINS)/$(POSIX_SHARED)

	(cd $(LEVELDB_SRC) && $(ANDROID_SETTINGS) make clean)

	cp -r assets/android/* $(ANDROID_PLUGINS)

$(IOS_PLUGINS)/$(LIBRARY_NAME):
	mkdir -p $(IOS_PLUGINS)

	(cd $(LEVELDB_SRC) && $(IOS_SETTINGS) make -j8)

	cp $(LEVELDB_SRC)/$(LIBRARY_NAME) $(IOS_PLUGINS)/$(LIBRARY_NAME)

	(cd $(LEVELDB_SRC) && $(ANDROID_SETTINGS) make clean)

	mkdir -p $(ASSETS)/Editor

	cp -r assets/ios/* $(ASSETS)/Editor

$(LEVELDB_ASSETS):
	mkdir -p $(LEVELDB_ASSETS)
	cp 3rdparty/leveldb-sharp/*.cs $(LEVELDB_ASSETS)
	cp 3rdparty/leveldb-sharp/LICENSE $(LEVELDB_ASSETS)
	python scripts/fixnative.py $(LEVELDB_ASSETS)/Native.cs

$(UNITYPACKAGE_BINARY):
	$(UNITY_OSX) -batchmode -projectPath $(UNITYPACKAGE) -exportPackage Assets/Plugins $(UNITYPACKAGE_BINARY) -quit

android: $(ANDROID_PLUGINS)/$(POSIX_SHARED)
ios: $(IOS_PLUGINS)/$(LIBRARY_NAME)

clean:
	rm -rf $(BUILDPATH)