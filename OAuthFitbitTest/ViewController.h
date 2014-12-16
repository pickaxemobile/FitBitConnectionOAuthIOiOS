//
//  ViewController.h
//  OAuthFitbitTest
//
//  Created by Anna Billstrom on 12/14/14.
//  Copyright (c) 2014 PickAxe Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OAUthiOS/OAuthiOS.h>

@interface ViewController : UIViewController<OAuthIODelegate>{
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *goalLabel;
    IBOutlet UIImageView *image;
}

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *goalLabel;
@property (nonatomic, strong) IBOutlet UIImageView *image;

-(IBAction)login:(id)sender;



@end

