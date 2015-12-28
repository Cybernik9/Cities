//
//  GameFoeOnePlayerViewController.m
//  Cities game
//
//  Created by Admin on 26.12.15.
//  Copyright © 2015 HY. All rights reserved.
//

#import "GameFoeOnePlayerViewController.h"
#import "LogicGame.h"

@interface GameFoeOnePlayerViewController ()

@property(strong, nonatomic)NSArray *citiesNameArray;
@property(strong, nonatomic)NSMutableArray *activeCitiesArray;

@property(strong, nonatomic)NSMutableArray *buttonArrayName;

@property(assign, nonatomic)NSInteger countOfCorrectAnswersPlayerOne;

@property(strong, nonatomic)NSString *answerPlayerOne;

@end


@implementation GameFoeOnePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    self.citiesNameArray = [LogicGame getCitiesName];
    
    self.activeCitiesArray = [[NSMutableArray alloc] init];
    self.activeCitiesArray = [LogicGame shuffle:self.citiesNameArray];
    
    self.countOfCorrectAnswersPlayerOne = 0;
    
    self.answerPlayerOne = [[NSString alloc] init];
    
    [self startGame];
}

- (void)startGame {
    
    [self.gameProgressView setProgress:0.f];
    
    [self logicGame];
}

- (void)setImagesWithName:(NSString *)nameImage {
    
    UIImage *image = [UIImage imageNamed:nameImage];
    
    self.playerOneImageView.image = image;
}

- (void)setTextToButtonWithArray:(NSMutableArray *)arrayName {
    
    [self.playerOneButtonA setTitle:[arrayName objectAtIndex:0] forState:UIControlStateNormal];
    [self.playerOneButtonB setTitle:[arrayName objectAtIndex:1] forState:UIControlStateNormal];
    [self.playerOneButtonC setTitle:[arrayName objectAtIndex:2] forState:UIControlStateNormal];
    [self.playerOneButtonD setTitle:[arrayName objectAtIndex:3] forState:UIControlStateNormal];
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
    
    [self.activeCitiesArray removeObject:[self.activeCitiesArray firstObject]];
    [self.gameProgressView setProgress:count/(CGFloat)[self.citiesNameArray count]];
    
    if ([self.activeCitiesArray count] == 0) {
        NSLog(@"Final!!!");
        
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Enter name"
                                              message:nil
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
                                                                 (long)self.countOfCorrectAnswersPlayerOne];
                                         
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
    else {
        [self logicGame];
    }
}

#pragma mark - Alert -

- (UIAlertController *)createAlertControllerWithTitle:(NSString *)title message:(NSString *)message {
    
    UIAlertController * alert =   [UIAlertController
                                   alertControllerWithTitle:title
                                   message:message
                                   preferredStyle:UIAlertControllerStyleAlert];
    
    return alert;
}

- (void)actionWithTitle:(NSString *)title alertTitle:(NSString *)alertTitle alertMessage:(NSString *)alertMessage {
    
    UIAlertController * alert = [self createAlertControllerWithTitle:alertTitle message:alertMessage];
    
    UIAlertAction* alertAction = [UIAlertAction
                                  actionWithTitle:title
                                  style:UIAlertActionStyleCancel
                                  handler:^(UIAlertAction * action) {
                                  }];
    
    [alert addAction:alertAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Action -

- (IBAction)actionPlayerOnePushButton:(id)sender {
    
    self.answerPlayerOne = [self.buttonArrayName objectAtIndex:[sender tag]];
    
    [self countCorrectAnswer];
}

@end
