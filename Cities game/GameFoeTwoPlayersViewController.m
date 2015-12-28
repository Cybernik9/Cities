//
//  ViewController.m
//  Cities game
//
//  Created by Admin on 25.12.15.
//  Copyright © 2015 HY. All rights reserved.
//

#import "GameFoeTwoPlayersViewController.h"
#import "LogicGame.h"
#import <QuartzCore/QuartzCore.h>

@interface GameFoeTwoPlayersViewController ()

@property(strong, nonatomic)NSArray *citiesNameArray;
@property(strong, nonatomic)NSMutableArray *activeCitiesArray;

@property(strong, nonatomic)NSMutableArray *buttonArrayName;

@property(assign, nonatomic)NSInteger countOfCorrectAnswersPlayerOne;
@property(assign, nonatomic)NSInteger countOfCorrectAnswersPlayerTwo;

@property(strong, nonatomic)NSString *answerPlayerOne;
@property(strong, nonatomic)NSString *answerPlayerTwo;

@end

@implementation GameFoeTwoPlayersViewController

static bool isOne;
static bool isTwo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [self.numberPlayer setTransform:CGAffineTransformMakeRotation(-M_PI)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.citiesNameArray = [LogicGame getCitiesName];
    
    self.activeCitiesArray = [[NSMutableArray alloc] init];
    self.activeCitiesArray = [LogicGame shuffle:self.citiesNameArray];
    
    self.countOfCorrectAnswersPlayerOne = 0;
    self.countOfCorrectAnswersPlayerTwo = 0;
    
    self.answerPlayerOne = [[NSString alloc] init];
    self.answerPlayerTwo = [[NSString alloc] init];
    
    [self startGame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startGame {
    
    [self.gameProgressView setProgress:0.f];
    
    [self logicGame];
}

- (void)setImagesWithName:(NSString *)nameImage {
    
    UIImage *image = [UIImage imageNamed:nameImage];
    
    self.playerOneImageView.image = self.playerTwoImageView.image = image;
    
    [self.playerOneImageView setTransform:CGAffineTransformMakeRotation(-M_PI)];
}

- (void)setTextToButtonWithArray:(NSMutableArray *)arrayName {

    [self.playerOneButtonA setTitle:[arrayName objectAtIndex:0] forState:UIControlStateNormal];
    [self.playerOneButtonA setTransform:CGAffineTransformMakeRotation(-M_PI)];
    [self.playerOneButtonB setTitle:[arrayName objectAtIndex:1] forState:UIControlStateNormal];
    [self.playerOneButtonB setTransform:CGAffineTransformMakeRotation(-M_PI)];
    [self.playerOneButtonC setTitle:[arrayName objectAtIndex:2] forState:UIControlStateNormal];
    [self.playerOneButtonC setTransform:CGAffineTransformMakeRotation(-M_PI)];
    [self.playerOneButtonD setTitle:[arrayName objectAtIndex:3] forState:UIControlStateNormal];
    [self.playerOneButtonD setTransform:CGAffineTransformMakeRotation(-M_PI)];
    
    [self.playerTwoButtonA setTitle:[arrayName objectAtIndex:0] forState:UIControlStateNormal];
    [self.playerTwoButtonB setTitle:[arrayName objectAtIndex:1] forState:UIControlStateNormal];
    [self.playerTwoButtonC setTitle:[arrayName objectAtIndex:2] forState:UIControlStateNormal];
    [self.playerTwoButtonD setTitle:[arrayName objectAtIndex:3] forState:UIControlStateNormal];
}

- (void)logicGame {
    
    [self setImagesWithName:[self.activeCitiesArray firstObject]];
    
    self.buttonArrayName = [LogicGame logicGameWithArray:self.activeCitiesArray];
    
    [self setTextToButtonWithArray:self.buttonArrayName];
}

- (void)countCorrectAnswer {
    
    static NSInteger count;
    count++;
    
    if ([self.answerPlayerOne isEqualToString:[self.activeCitiesArray firstObject]]) {
        self.countOfCorrectAnswersPlayerOne++;
    }
    
    if ([self.answerPlayerTwo isEqualToString:[self.activeCitiesArray firstObject]]) {
        self.countOfCorrectAnswersPlayerTwo++;
    }
    
    [self.activeCitiesArray removeObject:[self.activeCitiesArray firstObject]];
    [self.gameProgressView setProgress:count/(CGFloat)[self.citiesNameArray count]];
    
    if ([self.activeCitiesArray count] == 0) {
        NSLog(@"Final!!!");
        
        if (self.countOfCorrectAnswersPlayerOne == self.countOfCorrectAnswersPlayerTwo) {
            [self showAlertWithName:@"Player One"
                           andCount:self.countOfCorrectAnswersPlayerOne];
            [self showAlertWithName:@"Player Two"
                           andCount:self.countOfCorrectAnswersPlayerTwo];
            
        }
        else if (self.countOfCorrectAnswersPlayerOne > self.countOfCorrectAnswersPlayerTwo) {
            [self showAlertWithName:@"Player One"
                           andCount:self.countOfCorrectAnswersPlayerOne];
        } else {
            [self showAlertWithName:@"Player Two"
                           andCount:self.countOfCorrectAnswersPlayerTwo];
        }
    }
    else {
        [self logicGame];
    }
}

- (void)showAlertWithName:(NSString *)namePlayer andCount:(NSInteger)countPlayer {
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Enter name"
                                          message:namePlayer
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    //Adds a text field to the alert box
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = @"name";
     }];
    
    [self presentViewController:alertController animated:YES completion:nil];
    //Creates a button with actions to perform when clicked
    UIAlertAction *saveAction = [UIAlertAction
                                 actionWithTitle:@"Save"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction *action)
                                 {
                                     //Stores what has been inputted into the NSString Fullname
                                     
                                     UITextField * textField = alertController.textFields.firstObject;
                                     
                                     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                     
                                     NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:                                                                  [defaults objectForKey:@"player"]];
                                     
                                     NSString *tempString = [NSString stringWithFormat:@"%ld",
                                                             (long)countPlayer];
                                     
                                     NSDictionary *tempDictionary = [[NSDictionary alloc]
                                                                     initWithObjectsAndKeys:
                                                                     textField.text, @"name",
                                                                     tempString, @"count",
                                                                     nil];
                                     
                                     [tempArray addObject:tempDictionary];
                                     
                                     [defaults setObject:tempArray forKey:@"player"];
                                     
                                     UINavigationController * navigationController = self.navigationController;
                                     [navigationController popViewControllerAnimated:NO];
                                     
                                 }];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action) {
                                       UINavigationController * navigationController = self.navigationController;
                                       [navigationController popViewControllerAnimated:YES];
                                   }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:saveAction];
}

- (IBAction)actionPlayerOnePushButton:(id)sender {
    
    self.answerPlayerOne = [self.buttonArrayName objectAtIndex:[sender tag]];
    
    if (isTwo) {
        isTwo = NO;
        [self countCorrectAnswer];
    }
    else {
        isOne = YES;
    }
}

- (IBAction)actionPlayerTwoPushButton:(id)sender {
    
    self.answerPlayerTwo = [self.buttonArrayName objectAtIndex:[sender tag]];
    
    if (isOne) {
        isOne = NO;
        [self countCorrectAnswer];
    }
    else {
        isTwo = YES;
    }
}

@end
