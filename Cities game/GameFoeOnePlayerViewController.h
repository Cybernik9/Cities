//
//  GameFoeOnePlayerViewController.h
//  Cities game
//
//  Created by Admin on 26.12.15.
//  Copyright © 2015 HY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameFoeOnePlayerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIProgressView *gameProgressView;

@property (weak, nonatomic) IBOutlet UIImageView *playerOneImageView;

@property (weak, nonatomic) IBOutlet UIButton *playerOneButtonA;
@property (weak, nonatomic) IBOutlet UIButton *playerOneButtonB;
@property (weak, nonatomic) IBOutlet UIButton *playerOneButtonC;
@property (weak, nonatomic) IBOutlet UIButton *playerOneButtonD;

- (IBAction)actionPlayerOnePushButton:(id)sender;

@end
