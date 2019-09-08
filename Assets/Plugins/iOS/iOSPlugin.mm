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

+(NSString *)iCloudGetValue:(NSString *)key
{
    NSUbiquitousKeyValueStore *cloudStore = [NSUbiquitousKeyValueStore defaultStore];
    return [cloudStore objectForKey:key];
}

+(BOOL)iCloudSaveValue:(NSString *)key setValue:(NSString *)value
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

    const char * _iCloudGetValue(const char *key)
    {
        return cStringCopy([[iOSPlugin iCloudGetValue:[NSString stringWithUTF8String:key]] UTF8String]);
    }
    
    bool _iCloudSaveValue(const char *key, const char *value)
    {
        return [iOSPlugin iCloudSaveValue:[NSString stringWithUTF8String:key] setValue:[NSString stringWithUTF8String:value]];
    }
}
