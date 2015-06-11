//
//  ViewController.m
//  PayWithTweet
//
//  Created by LetsGoMo Labs on 6/11/15.
//  Copyright (c) 2015 LetsGoMo Labs. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Methods

- (IBAction)shareButton:(UIButton *)sender
{
    UIActionSheet *sharingSheet = [[UIActionSheet alloc] initWithTitle:@"Share the app"
                                                              delegate:self
                                                     cancelButtonTitle:@"Cancel"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"Tweet",
                                                        @"Share on faceboook",
                                                        nil];
    [sharingSheet showInView:self.view];
}

#pragma  mark - UIActionSheetDelegate Methods

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        NSLog(@"Tweet Button Pressed.");
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            SLComposeViewController *tweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [tweet setInitialText:@"I just installed the app. You should also try it !"];
            [tweet addURL:[NSURL URLWithString:@"http://snapdeal.com"]];
            [tweet addImage:[UIImage imageNamed:@"snapdeal.png"]];
            [tweet setCompletionHandler:^(SLComposeViewControllerResult result)
             {
                 if (result == SLComposeViewControllerResultCancelled)
                 {
                     NSLog(@"The user cancelled.");
                 }
                 else if (result == SLComposeViewControllerResultDone)
                 {
                     NSLog(@"The user sent the tweet");
                 }
             }];
            [self presentViewController:tweet animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter"
                                                            message:@"Twitter integration is not available.  A Twitter account must be set up on your device."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
    }
    else if (buttonIndex == 1)
    {
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            SLComposeViewController *facebook = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [facebook setInitialText:@"I just completed the Social.framework Tutorial by @iosdevtutorials !"];
            [facebook addURL:[NSURL URLWithString:@"http://snapdeal.com"]];
            [facebook addImage:[UIImage imageNamed:@"snapdeal.png"]];
            [facebook setCompletionHandler:^(SLComposeViewControllerResult result)
             {
                 if (result == SLComposeViewControllerResultCancelled)
                 {
                     NSLog(@"The user cancelled.");
                 }
                 else if (result == SLComposeViewControllerResultDone)
                 {
                     NSLog(@"The user posted to Facebook");
                 }
             }];
            [self presentViewController:facebook animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook"
                                                            message:@"Facebook integration is not available.  A Facebook account must be set up on your device."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
}

@end
