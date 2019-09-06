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
    [UnityGetGLViewController() presentViewController:controller animated:YES completion:nil];
    
    //if iPhone
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [UnityGetGLViewController() presentViewController:controller animated:YES completion:nil];
    }
    //if iPad
    else {
        UIPopoverPresentationController* popOver = controller.popoverPresentationController;
        if(popOver){
            popOver.sourceView = controller.view;
            popOver.sourceRect = CGRectMake(UnityGetGLViewController().view.frame.size.width/2, UnityGetGLViewController().view.frame.size.height/4, 0, 0);
            [UnityGetGLViewController() presentViewController:controller animated:YES completion:nil];
        }
    }
}

@end

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
}
