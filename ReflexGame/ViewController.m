//
//  ViewController.m
//  ReflexGame
//
//  Created by Bastian Morath on 08/02/14.
//  Copyright (c) 2014 Bastian Morath. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    buttonTagToPress = 0;
    level=1;
    tagToDelete=1;
    secondesLeft = 10;

    levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 140, self.view.frame.size.width-60, 100)];
    levelLabel.textColor=[UIColor whiteColor];
    levelLabel.textAlignment=NSTextAlignmentCenter;
    levelLabel.numberOfLines = 0;
    levelLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:20];
    
    [self.view addSubview:levelLabel];

    self.timeLabel.text=[NSString stringWithFormat:@"%i", secondesLeft];
    
    /*Touch ändern*/
    for (int i=1;i<35; i++) {
        UIButton *button= (UIButton*)[self.view viewWithTag:i];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
    }
    
}

-(void)highliteNewButton{
    [[self.view viewWithTag:buttonTagToPress] setBackgroundColor:[UIColor colorWithRed:101/255.0f green:228/255.0f blue:197/255.0f alpha:1]];
    int newTag = arc4random() %35;
    while (newTag==0 || newTag == buttonTagToPress) {
        newTag= arc4random() %35;
    }
    buttonTagToPress= newTag;

    UIButton *buttonToHighlite= (UIButton*)[self.view viewWithTag:buttonTagToPress];
    
    [buttonToHighlite setBackgroundColor:[UIColor colorWithRed:1 green:106/255.0f blue:62/255.0f alpha:1]];
}


-(void)updateScoreLabel{
    self.pointsLabel.text= [NSString stringWithFormat:@"%i", score];
}



- (IBAction)startButtonPressed:(id)sender {
    UIButton *button= sender;
    buttonTagToPress = 1;

    score=0;
    self.pointsLabel.text= [NSString stringWithFormat:@"0"];

    tagToDelete=1;
    [scoreLabel1 setHidden:YES];
    [scoreLabel2 setHidden:YES];
    [highscoreLabel setHidden:YES];
    [levelLabel setHidden:YES];
    /*Show all buttons ans Labels*/
    [self.pointsLabel setHidden:NO];
    self.timeLabel.text= @"10";

    [self.timeLabel setHidden:NO];
    
    for (int i=1;i<=35; i++) {
        [self.view viewWithTag:i].backgroundColor=[UIColor colorWithRed:101/255.0f green:228/255.0f blue:197/255.0f alpha:1];
    }
    button.alpha=0.3;
    timer = [NSTimer scheduledTimerWithTimeInterval:(0.6-(0.02*level)) target:self selector:@selector(highliteNewButton)userInfo:nil repeats:YES];
    countdownTimer=[NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(enumerateLabel)userInfo:nil repeats:YES];
    [button setUserInteractionEnabled:NO];
}

-(void)enumerateLabel{
    secondesLeft--;

    if (secondesLeft==0) {
        [countdownTimer invalidate];
        [timer invalidate];
        [self littleBreak];
        
    }
    self.timeLabel.text= [NSString stringWithFormat:@"%i", secondesLeft];
}
-(void)endGame{
    [levelLabel setHidden:NO];

    if (score>10) {
        levelLabel.text= [NSString stringWithFormat:@"Level %i - Successfull! \n You scored more than 10 points", level];
        level++;

    } else {
        
        levelLabel.text= [NSString stringWithFormat:@"Level %i - Failed!", level];
    }
    secondesLeft=10;
    if (level>[self highscore]) {
          NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:level forKey:@"highscore"];
    }
         
    /*hide Labels*/
    [self.pointsLabel setHidden:YES];
    [self.timeLabel setHidden:YES];
    scoreLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 230, self.view.frame.size.width - 40, 40)];
    scoreLabel1.textColor=[UIColor whiteColor];
    scoreLabel1.textAlignment=NSTextAlignmentCenter;
    scoreLabel2.font=[UIFont fontWithName:@"Helvetica Neue" size:20];

    scoreLabel1.text= [NSString stringWithFormat:@"Your Score is"];
    [self.view addSubview:scoreLabel1];

    scoreLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 280, self.view.frame.size.width - 40, 40)];
    scoreLabel2.textColor=[UIColor whiteColor];
    scoreLabel2.textAlignment=NSTextAlignmentCenter;
    scoreLabel2.font=[UIFont fontWithName:@"Helvetica Neue" size:40];
    scoreLabel2.text= [NSString stringWithFormat:@"%i", score];
    [self.view addSubview:scoreLabel2];
    
    highscoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, self.view.frame.size.height-200, self.view.frame.size.width - 40, 40)];
    highscoreLabel.textColor=[UIColor whiteColor];
    highscoreLabel.textAlignment=NSTextAlignmentCenter;
    highscoreLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:20];
    highscoreLabel.text= [NSString stringWithFormat:@"Highscore: Level %i", [self highscore]];
    [self.view addSubview:highscoreLabel];

    

    [self.startButton setUserInteractionEnabled:YES];
    self.startButton.backgroundColor=[UIColor colorWithRed:1 green:106/255.0f blue:62/255.0f alpha:1];
    self.startButton.alpha=1;
    [timer invalidate];
    
}
-(void)littleBreak{
    [self.view viewWithTag:tagToDelete].backgroundColor=[UIColor colorWithRed:0/255.0f green:181/255.0f blue:227/255.0f alpha:1];
    tagToDelete++;
    NSTimer *littleBreak= [NSTimer scheduledTimerWithTimeInterval:(0.02) target:self selector:@selector(littleBreak2)userInfo:nil repeats:NO];
    if (tagToDelete==36) {
        NSTimer *endGame= [NSTimer scheduledTimerWithTimeInterval:(0.02) target:self selector:@selector(endGame)userInfo:nil repeats:NO];
        [littleBreak invalidate];
    }
    }
-(void)littleBreak2{
    
    [self.view viewWithTag:tagToDelete].backgroundColor=[UIColor colorWithRed:0/255.0f green:181/255.0f blue:227/255.0f alpha:1];
    tagToDelete++;
    NSTimer *littleBreak= [NSTimer scheduledTimerWithTimeInterval:(0.02) target:self selector:@selector(littleBreak)userInfo:nil repeats:NO];
    if (tagToDelete==36) {
        NSTimer *endGame= [NSTimer scheduledTimerWithTimeInterval:(0.02) target:self selector:@selector(endGame)userInfo:nil repeats:NO];
        [littleBreak invalidate];
    }
    
}
- (IBAction)buttonPressed:(id)sender {
    
    UIButton *button=sender;
    if (buttonTagToPress==button.tag) {
        score +=1;
        [self updateScoreLabel];
    }

}

-(int) highscore {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger highscore = [defaults integerForKey:@"highscore"];
    return (int) highscore;
}
@end
