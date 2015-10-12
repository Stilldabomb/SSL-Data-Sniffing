#include <dlfcn.h>
#include <Security/SecureTransport.h>
#include <Security/Security.h>
#include <syslog.h>
#include <inttypes.h>
#include "/opt/theos/include/substrate.h"
#include <Foundation/Foundation.h>

#define HB_LOG_FORMAT(color) "\e[1;3" #color "m%s:\e[m\e[0;3" #color "m%d\e[m \e[0;30;4" #color "m%s:\e[m %s"
#define HB_LOG_INTERNAL(color, level, type, ...) syslog(level, HB_LOG_FORMAT(color), __FILE__, __LINE__, type, [NSString stringWithFormat:__VA_ARGS__].UTF8String);
#define HBLogDebug(...) HB_LOG_INTERNAL(6, LOG_NOTICE, "DEBUG", __VA_ARGS__)

static void *(*orig_ssl_write)();
static void *(*orig_ssl_read)();
void *ssl_write(SSLContextRef context, const void *data, size_t dataLength, size_t *processed) {
    HBLogDebug(@"SSLWrite( , %s, %zu, %zu)", (char*)data, dataLength, *processed);
    return orig_ssl_write(context, data, dataLength, processed);
}

void *ssl_read(SSLContextRef context, void *data, size_t dataLength, size_t *processed) {
    HBLogDebug(@"SSLRead( , %s, %zu, %zu)", (char*)data, dataLength, *processed);
    return orig_ssl_read(context, data, dataLength, processed);
}

__attribute__((constructor))
static void ctor(void) {
    MSHookFunction(dlsym(RTLD_DEFAULT, "SSLWrite"), &ssl_write, &orig_ssl_write);
    // I recommend not hooking this, it causes lots of spam. Do it if you really want though.
    //MSHookFunction(dlsym(RTLD_DEFAULT, "SSLRead"), &ssl_read, &orig_ssl_read);
}

//OSStatus SSLWrite(SSLContextRef context, const void *data, size_t dataLength, size_t *processed)
//OSStatus SSLRead(SSLContextRef context, void *data, size_t dataLength, size_t *processed) 
