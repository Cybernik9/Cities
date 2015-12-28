//
//  ViewController.h
//  Cities game
//
//  Created by Admin on 25.12.15.
//  Copyright © 2015 HY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameFoeTwoPlayersViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIProgressView *gameProgressView;

#pragma mark - Player One

@property (weak, nonatomic) IBOutlet UIImageView *playerOneImageView;

@property (weak, nonatomic) IBOutlet UIButton *playerOneButtonA;
@property (weak, nonatomic) IBOutlet UIButton *playerOneButtonB;
@property (weak, nonatomic) IBOutlet UIButton *playerOneButtonC;
@property (weak, nonatomic) IBOutlet UIButton *playerOneButtonD;
@property (weak, nonatomic) IBOutlet UILabel *numberPlayer;

- (IBAction)actionPlayerOnePushButton:(id)sender;


#pragma mark - Player Two

@property (weak, nonatomic) IBOutlet UIImageView *playerTwoImageView;

@property (weak, nonatomic) IBOutlet UIButton *playerTwoButtonA;
@property (weak, nonatomic) IBOutlet UIButton *playerTwoButtonB;
@property (weak, nonatomic) IBOutlet UIButton *playerTwoButtonC;
@property (weak, nonatomic) IBOutlet UIButton *playerTwoButtonD;

- (IBAction)actionPlayerTwoPushButton:(id)sender;

@end
