//
//  ViewController.m
//  OAuthFitbitTest
//
//  Created by Anna Billstrom on 12/14/14.
//  Copyright (c) 2014 PickAxe Mobile LLC. All rights reserved.
//


#import "ViewController.h"
#import "Constants.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize nameLabel, goalLabel, image;

- (void)didReceiveOAuthIOResponse:(OAuthIORequest *)request{
    NSLog(@"request received");
    
    NSDictionary *credentials = [request getCredentials];
    NSLog(@"creds: %@", credentials);
    
    
    //https://api.fitbit.com/5/user/-/profile.json
    [request get:@"/1/user/-/profile.json" success:^(NSDictionary *output, NSString *body, NSHTTPURLResponse *httpResponse)
     {
         NSData* data = [body dataUsingEncoding:NSUTF8StringEncoding];
         
         if([[output allKeys] count] > 0){
             NSLog(@"output exists: %@:", output);
         } else {
             NSLog(@"output empty");
             NSError *error;
             NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
             if([[dictionary allKeys] count] > 0){
                 NSLog(@"dictionary: %@", dictionary);
                 NSDictionary *user = [dictionary objectForKey:@"user"];
                 NSString *name = [user objectForKey:@"displayName"];
                 nameLabel.text = [NSString stringWithFormat:@"Hello %@!", name];
                 //TODO if we want imag,e use SDWebImage
                 
                 
                 // image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[user objectForKey:@"avatar"]]];
             }
         }
         
         
         
     }];
    
    [request get:@"/1/user/-/activities/goals/daily.json" success:^(NSDictionary *output, NSString *body, NSHTTPURLResponse *httpResponse)
     {
         NSData* data = [body dataUsingEncoding:NSUTF8StringEncoding];
         NSError *error;
         NSDictionary *dictionary =[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
         NSDictionary *goals = [dictionary objectForKey:@"goals"];
         NSString *stepGoalAmount = [goals objectForKey:@"steps"];
         goalLabel.text = [NSString stringWithFormat:@"Your daily step goal: %@",stepGoalAmount];
         NSLog(@"goals: %@", goals);

         NSLog(@"stepgoalamt: %@", stepGoalAmount);

     }];
}

- (void)didFailWithOAuthIOError:(NSError *)error{
    NSLog(@"error: %@", error.localizedDescription);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)login:(id)sender{
    OAuthIOModal *oauthioModal = [[OAuthIOModal alloc] initWithKey:OAUTH_IO_PUBLIC_KEY delegate:self];
//    [oauthioModal showWithProvider:@"fitbit"];
    NSLog(@"login tapped");
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    [options setObject:@"true" forKey:@"cache"];
    [oauthioModal showWithProvider:@"fitbit" options:options];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
