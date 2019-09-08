#import "UnityAppController.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern UIViewController *UnityGetGLViewController();

@interface iOSPlugin : NSObject

@end

@implementation iOSPlugin

+(void)alertView:(NSString*)title addMessage:(NSString*) message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:defaultAction];
    [UnityGetGLViewController() presentViewController:alert animated:YES completion:nil];
}

+(void)alertConfirmationView:(NSString*)title addMessage:(NSString*)message addCallBack:(NSString*)callback
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action){
                                                         UnitySendMessage("iOSPluginCallBacks", [callback UTF8String], "");
                                                     }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [UnityGetGLViewController() presentViewController:alert animated:YES completion:nil];
}

+(void)shareView:(NSString *)message addUrl:(NSString *)url
{
    NSURL *postUrl = [NSURL URLWithString:url];
    NSArray *postItems=@[message,postUrl];
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:postItems applicationActivities:nil];
    
    //if iPhone
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [UnityGetGLViewController() presentViewController:controller animated:YES completion:nil];
    }
    //if iPad
    else {
        UIPopoverPresentationController *popOver = controller.popoverPresentationController;
        if(popOver){
            popOver.sourceView = controller.view;
            popOver.sourceRect = CGRectMake(UnityGetGLViewController().view.frame.size.width/2, UnityGetGLViewController().view.frame.size.height/4, 0, 0);
            [UnityGetGLViewController() presentViewController:controller animated:YES completion:nil];
        }
    }
}

+(int)getBatteryStatus
{
    UIDevice *myDevice = [UIDevice currentDevice];
    [myDevice setBatteryMonitoringEnabled:YES];
    return [myDevice batteryState];
}

+(NSString *)getBatteryLevel
{
    UIDevice *myDevice = [UIDevice currentDevice];
    [myDevice setBatteryMonitoringEnabled:YES];
    
    double batLeft = (float)[myDevice batteryLevel] * 100;
    return [NSString stringWithFormat:@"battery left: %f", batLeft];
}

// get or load integer values
+(int)iCloudGetIntValue:(NSString *)key
{
    NSUbiquitousKeyValueStore *cloudStore = [NSUbiquitousKeyValueStore defaultStore];
    return [[cloudStore objectForKey:key] intValue];
}

+(BOOL)iCloudSaveIntValue:(NSString *)key setValue:(long)value
{
    NSUbiquitousKeyValueStore *cloudStore = [NSUbiquitousKeyValueStore defaultStore];
    [cloudStore setLongLong:value forKey:key];
    return [cloudStore synchronize];
}

// get or load bool values
+(BOOL)iCloudGetBoolValue:(NSString *)key
{
    NSUbiquitousKeyValueStore *cloudStore = [NSUbiquitousKeyValueStore defaultStore];
    return [[cloudStore objectForKey:key] boolValue];
}

+(BOOL)iCloudSaveBoolValue:(NSString *)key setValue:(BOOL)value
{
    NSUbiquitousKeyValueStore *cloudStore = [NSUbiquitousKeyValueStore defaultStore];
    [cloudStore setBool:value forKey:key];
    return [cloudStore synchronize];
}

// get or load string values
+(NSString *)iCloudGetStringValue:(NSString *)key
{
    NSUbiquitousKeyValueStore *cloudStore = [NSUbiquitousKeyValueStore defaultStore];
    return [cloudStore objectForKey:key];
}

+(BOOL)iCloudSaveStringValue:(NSString *)key setValue:(NSString *)value
{
    NSUbiquitousKeyValueStore *cloudStore = [NSUbiquitousKeyValueStore defaultStore];
    [cloudStore setObject:value forKey:key];
    return [cloudStore synchronize];
}

@end

char* cStringCopy(const char* string)
{
    if (string == NULL)
        return NULL;
    
    char* res = (char*)malloc(strlen(string) + 1);
    strcpy(res, string);
    
    return res;
}

extern "C"
{
    void _ShowAlert(const char *title, const char *message)
    {
        [iOSPlugin alertView:[NSString stringWithUTF8String:title] addMessage:[NSString stringWithUTF8String:message]];
    }
    
    void _ShowAlertConfirmation(const char *title, const char *message, const char *callBack)
    {
        [iOSPlugin alertConfirmationView:[NSString stringWithUTF8String:title] addMessage:[NSString stringWithUTF8String:message]  addCallBack:[NSString stringWithUTF8String:callBack]];
    }
    
    void _ShareMessage(const char *message, const char *url)
    {
        [iOSPlugin shareView:[NSString stringWithUTF8String:message] addUrl:[NSString stringWithUTF8String:url]];
    }
    
    int _GetBatteryStatus()
    {
        return [iOSPlugin getBatteryStatus];
    }
    
    const char * _GetBatteryLevel()
    {
        return cStringCopy([[iOSPlugin getBatteryLevel] UTF8String]);
    }
    
    const char * _iCloudGetStringValue(const char *key)
    {
        return cStringCopy([[iOSPlugin iCloudGetStringValue:[NSString stringWithUTF8String:key]] UTF8String]);
    }
    
    bool _iCloudSaveStringValue(const char *key, const char *value)
    {
        return [iOSPlugin iCloudSaveStringValue:[NSString stringWithUTF8String:key] setValue:[NSString stringWithUTF8String:value]];
    }
    
    int _iCloudGetIntValue(const char *key)
    {
        return [iOSPlugin iCloudGetIntValue:[NSString stringWithUTF8String:key]];
    }
    
    bool _iCloudSaveIntValue(const char *key, int value)
    {
        return [iOSPlugin iCloudSaveIntValue:[NSString stringWithUTF8String:key] setValue:value];
    }
    
    bool _iCloudGetBoolValue(const char *key)
    {
        return [iOSPlugin iCloudGetBoolValue:[NSString stringWithUTF8String:key]];
    }
    
    bool _iCloudSaveBoolValue(const char *key, bool value)
    {
        return [iOSPlugin iCloudSaveBoolValue:[NSString stringWithUTF8String:key] setValue:value];
    }
}
