# SSL-Data-Sniffing
Simple tweak code to sniff SSL data, builds via clang since Theos wouldn't build it and I was too lazy to fix that.

### How to Use
Install the dylib and plist to /Library/MobileSubstrate/DynamicLibraries or use the install script. Install [deviceconsole](https://github.com/rpetrich/deviceconsole) (can use `brew install hbang/repo/deviceconsole --HEAD`). Run `deviceconsole` in console and read the SSLWrite/SSLRead outputs with blue highlighted "DEBUG".

### Credits
`HBLogDebug(...)` and helping with building - [Adam Demasi](https://twitter.com/hbkirb) ([his theos](https://github.com/kirb/theos))

Helping with C hooking - [Thomas Finch](https://twitter.com/tomf64)
