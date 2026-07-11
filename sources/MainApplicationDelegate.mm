#import <CoreText/CoreText.h>
#import "MainApplicationDelegate.h"
#import "RootViewController.h"
#import <Lottie/Lottie-Swift.h>
#import "si.h"

@implementation MainApplicationDelegate {
    RootViewController *_rootViewController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    
    if (@available(iOS 13.0, *)) {
        self.window.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    }
    
    _rootViewController = [[RootViewController alloc] init];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:_rootViewController];
    navController.navigationBar.prefersLargeTitles = NO;
    navController.navigationBar.translucent = YES;
    
    [self.window setRootViewController:navController];
    [self.window makeKeyAndVisible];

    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:cv options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSDictionary *animationData = nil;
    if (decodedData) {
        animationData = [NSJSONSerialization JSONObjectWithData:decodedData options:kNilOptions error:nil];
    }

    if (animationData) {
        CompatibleAnimation *animation = [[CompatibleAnimation alloc] initWithDictionary:animationData];
        if (animation) {
            CompatibleAnimationView *animationView = [[CompatibleAnimationView alloc] initWithCompatibleAnimation:animation];
            if (animationView) {

                animationView.frame = CGRectMake(0, 0, 100, 100);
                animationView.center = self.window.center;
                animationView.contentMode = UIViewContentModeScaleAspectFit;
                
                [self.window addSubview:animationView];
                
                [animationView playWithCompletion:^(BOOL animationFinished) {
                    [UIView animateWithDuration:0.3 animations:^{
                        animationView.alpha = 0.0;
                    } completion:^(BOOL finished) {
                        [animationView removeFromSuperview];
                    }];
                }];
            }
        }
    }

    return YES;
}

@end
