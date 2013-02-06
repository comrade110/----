//
//  ViewController.m
//  开心填字
//
//  Created by user on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "LevelViewController.h"


@implementation ViewController

@synthesize startBtn;

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)startBtnPress:(id)sender
{
    LevelViewController *levelview = [[LevelViewController alloc] init];
    
    [self presentModalViewController:levelview animated:YES];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
