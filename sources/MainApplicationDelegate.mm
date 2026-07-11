#import <CoreText/CoreText.h>
#import "MainApplicationDelegate.h"
#import "RootViewController.h"
#import <Lottie/Lottie-Swift.h>
#import "si.h" // นำเข้าไฟล์ที่เก็บตัวแปรสตริง Base64

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

    // 1. แปลง Base64 String จาก si.h กลับเป็น NSData
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:cv options:NSDataBase64DecodingIgnoreUnknownCharacters];

    // 2. เริ่มต้นสร้างแอนิเมชันโดยส่งข้อมูลดิบ NSData ไปที่ตัว View
    if (decodedData) {
        CompatibleAnimationView *animationView = [[CompatibleAnimationView alloc] initWithData:decodedData];
        if (animationView) {
            // 3. ปรับขนาดกว้างยาวของ Lottie เป็น 100 และจัดตำแหน่งให้อยู่กึ่งกลางหน้าจอ
            animationView.frame = CGRectMake(0, 0, 100, 100);
            animationView.center = self.window.center;
            animationView.contentMode = UIViewContentModeScaleAspectFit;
            
            // บังคับให้อยู่บนสุดของ Window ชั่วคราว
            [self.window addSubview:animationView];
            
            // 4. เล่นแอนิเมชันจนจบก่อน แล้วค่อยๆ Fade Out เพื่อเข้าสู่หน้าหลัก
            [animationView playWithCompletion:^(BOOL animationFinished) {
                [UIView animateWithDuration:0.3 animations:^{
                    animationView.alpha = 0.0;
                } completion:^(BOOL finished) {
                    [animationView removeFromSuperview];
                }];
            }];
        }
    }

    return YES;
}

@end
