DYLIB_NAME=sslhook

rm -f "$DYLIB_NAME".dylib
xcrun -sdk iphoneos clang -dynamiclib -arch arm64 -arch armv7 inject.m ./libsubstrate_arm.dylib /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/System/Library/Frameworks/Foundation.framework/Foundation.tbd -o "$DYLIB_NAME".dylib
scp -P 2222 "$DYLIB_NAME".dylib root@localhost:/Library/MobileSubstrate/DynamicLibraries/
echo "<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"><plist version="1.0"><dict><key>Filter</key><dict><key>Bundles</key><array><string>com.apple.Security</string></array></dict></dict></plist>" > "$DYLIB_NAME".plist
scp -P 2222 "$DYLIB_NAME".plist root@localhost:/Library/MobileSubstrate/DynamicLibraries/"$DYLIB_NAME".plist
rm -f "$DYLIB_NAME".plist
ssh -p 2222 root@localhost "killall -9 SpringBoard"
