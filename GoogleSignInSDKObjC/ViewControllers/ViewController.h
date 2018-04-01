//
//  ViewController.h
//  GoogleSignInSDKObjC
//
//  Created by rakshith appaiah on 3/31/18.
//  Copyright © 2018 rakshith appaiah. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleSignIn;
@import Locksmith;
@import Security;

@interface ViewController : UIViewController <GIDSignInDelegate,GIDSignInUIDelegate>

@end
