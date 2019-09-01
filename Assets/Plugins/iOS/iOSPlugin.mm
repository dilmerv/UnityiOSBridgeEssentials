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

    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
        handler:^(UIAlertAction *action){}];

    [alert addAction:defaultAction];
    [UnityGetGLViewController() presentViewController:alert animated:YES completion:nil];
}

@end

extern "C"
{
    void _ShowAlert(const char *title, const char *message)
    {
        [iOSPlugin alertView:[NSString stringWithUTF8String:title] addMessage:[NSString stringWithUTF8String:message]];
    }
}
