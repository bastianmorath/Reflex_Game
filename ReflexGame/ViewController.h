//
//  ViewController.h
//  ReflexGame
//
//  Created by Bastian Morath on 08/02/14.
//  Copyright (c) 2014 Bastian Morath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    int score;
    int buttonTagToPress;
    NSTimer *timer;
    NSTimer *countdownTimer;
    int secondesLeft;
    int tagToDelete;

    UILabel *scoreLabel1;
    UILabel *scoreLabel2;
    UILabel *levelLabel;
    UILabel *highscoreLabel;

    int level;
}
- (IBAction)buttonPressed:(id)sender;

@property (retain, nonatomic) IBOutletCollection(UIButton) NSMutableArray *buttons;
@property (strong, nonatomic) IBOutlet UILabel *pointsLabel;

@property (strong, nonatomic) IBOutlet UIButton *startButton;
- (IBAction)startButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@end
