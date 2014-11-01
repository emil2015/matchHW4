//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Sameh Fakhouri on 10/8/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;
@end

@implementation HistoryViewController

- (void)setGameHistory:(NSAttributedString *)gameHistory
{
    NSLog(@"HistoryViewController - setHistory - Start");
    _gameHistory = gameHistory;
    if (self.view.window) {
        [self updateUI];
    }
    NSLog(@"HistoryViewController - setHistory - End");
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"HistoryViewController - viewWillAppear - Start");
    [super viewWillAppear:animated];
    [self updateUI];
    NSLog(@"HistoryViewController - viewWillAppear - End");
}

- (void)updateUI
{
    NSLog(@"HistoryViewController - updateUI - Start");
    self.historyTextView.attributedText = self.gameHistory;
    NSLog(@"HistoryViewController - updateUI - End");
}

@end
