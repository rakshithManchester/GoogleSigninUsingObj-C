//
//  ViewController.m
//  GoogleSignInSDKObjC
//
//  Created by rakshith appaiah on 3/31/18.
//  Copyright © 2018 rakshith appaiah. All rights reserved.
//

#import "ViewController.h"
#import <Security/Security.h>


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *GIDSignInButton;
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [GIDSignIn sharedInstance].delegate = self;
    [GIDSignIn sharedInstance].uiDelegate = self;
    
    _container.layer.cornerRadius = 5;
    _container.layer.masksToBounds = true;
    
    _loginButton.layer.cornerRadius = 5;
    _loginButton.layer.masksToBounds = true;
    
}


- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    
    /**
     Alert Error.
     */
    if(error != nil){
        UIAlertController *uiAlertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert] ;
        UIAlertAction *uiAlertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [uiAlertController addAction:uiAlertAction];
        [self presentViewController:uiAlertController animated:true completion:nil];
    } else {
        
        /**
         Encryption Key - PBKDF2WithHmacSHA1.
         */
        NSString *encryptKey = @"PBKDF2WithHmacSHA1";
        
        // Create dictionary of search parameters
        NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)(kSecClassInternetPassword),  kSecClass, encryptKey, kSecAttrServer, kCFBooleanTrue, kSecReturnAttributes, nil];
        // Remove any old values from the keychain
        OSStatus err = SecItemDelete((__bridge CFDictionaryRef) dict);
        
        // Create dictionary of parameters to add
        NSData* idToken = [user.authentication.idToken dataUsingEncoding:NSUTF8StringEncoding];
        NSString* userID = user.userID ;
        NSString* userEmail = user.profile.email;
        NSString* name = user.profile.name;
        NSString* givenName = user.profile.givenName;
        
        dict = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)(kSecClassInternetPassword), kSecClass, encryptKey, kSecAttrServer, idToken, kSecValueData, userID, kSecAttrAccount,userEmail, kSecAttrDescription,name,kSecAttrComment,givenName,kSecAttrLabel,nil];
        // Try to save to keychain
        err = SecItemAdd((__bridge CFDictionaryRef) dict, NULL);
        
        [self performSegueWithIdentifier:@"tableVwSegue" sender:self];
    }
}

/**
  Present a view that prompts the user to sign in with Google
 */
- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

/**
 Dismiss the "Sign in with Google" view
 */
- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end


