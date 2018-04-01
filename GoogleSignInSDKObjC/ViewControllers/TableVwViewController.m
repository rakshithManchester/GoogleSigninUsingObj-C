//
//  TableVwViewController.m
//  GoogleSignInSDKObjC
//
//  Created by rakshith appaiah on 4/1/18.
//  Copyright © 2018 rakshith appaiah. All rights reserved.
//

#import "TableVwViewController.h"
#import "CustomTableViewCell.h"

@interface TableVwViewController ()
- (IBAction)signOut:(id)sender;
@property NSMutableArray *myMutableArray;
@property (weak, nonatomic) IBOutlet UITableView *tableVw;
@property (weak, nonatomic) IBOutlet UIButton *signOutButton;

@end

@implementation TableVwViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     _signOutButton,_tableVw UI
     */
    [_signOutButton layer].borderWidth = 1;
    [_signOutButton layer].borderColor = (__bridge CGColorRef _Nullable)([UIColor redColor]);
    [_tableVw layer].borderWidth = 0.5;
    [_tableVw layer].cornerRadius = 7;
    [_tableVw layer].masksToBounds = true;
    
    /**
     Encryption Key - PBKDF2WithHmacSHA1.
     */
    NSString *encryptKey = @"PBKDF2WithHmacSHA1";
    
    // Create dictionary of search parameters
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)(kSecClassInternetPassword),  kSecClass, encryptKey, kSecAttrServer, kCFBooleanTrue, kSecReturnAttributes, kCFBooleanTrue, kSecReturnData, nil];
    // Look up server in the keychain
    NSDictionary* found = nil;
    CFDictionaryRef foundCF;
    OSStatus err = SecItemCopyMatching((__bridge CFDictionaryRef) dict, (CFTypeRef*)&foundCF);
    NSLog(@"%d",(int)err);
    found = (__bridge NSDictionary*)(foundCF);
    if (!found) return;
    /**
     Decrypting userID,userEmail,name,givenName,idToken to NSMutableArray.
     */
    NSString* userID = (NSString*) [found objectForKey:(__bridge id)(kSecAttrAccount)];
    NSString* userEmail = (NSString*) [found objectForKey:(__bridge id)(kSecAttrDescription)];
    NSString* name = (NSString*) [found objectForKey:(__bridge id)(kSecAttrComment)];
    NSString* givenName = (NSString*) [found objectForKey:(__bridge id)(kSecAttrLabel)];
    NSString* idToken = [[NSString alloc] initWithData:[found objectForKey:(__bridge id)(kSecValueData)] encoding:NSUTF8StringEncoding];
    _myMutableArray =  [[NSMutableArray alloc] initWithObjects:userID,userEmail,name,givenName,idToken, nil];
}

#pragma number of rows in section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

#pragma cell for rows.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"customCell";
    CustomTableViewCell *customTableViewCell = [tableView dequeueReusableCellWithIdentifier:cellId];
    switch (indexPath.section) {
        case 0:
            [customTableViewCell details].text = _myMutableArray[indexPath.section];
            return customTableViewCell;
            break;
        case 1:
            [customTableViewCell details].text = _myMutableArray[indexPath.section];
            return customTableViewCell;
            break;
        case 2:
            [customTableViewCell details].text = _myMutableArray[indexPath.section];
            return customTableViewCell;
            break;
        case 3:
            [customTableViewCell details].text = _myMutableArray[indexPath.section];
            return customTableViewCell;
            break;
        default:
            [customTableViewCell details].text = _myMutableArray[indexPath.section];
            return customTableViewCell;
            break;
    }
}

#pragma number of sections in table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_myMutableArray count];
}

#pragma section header title.
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"User ID";
        case 1:
            return @"User Email";
        case 2:
            return @"Name";
        case 3:
            return @"Given Name";
        default:
            return @"Token";
    }
}

/**
 signOut button action.
 */
- (IBAction)signOut:(id)sender {
    [[GIDSignIn sharedInstance] signOut];
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
