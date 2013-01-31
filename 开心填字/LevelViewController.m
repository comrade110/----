//
//  LevelViewController.m
//  开心填字
//
//  Created by user on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LevelViewController.h"

#define PER_PAGE_LVL_NUM 20

@interface LevelViewController ()

@end

@implementation LevelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *dataPath = [path stringByAppendingPathComponent:@"en.lproj/Localizable.strings"];
    NSDictionary *tempDict = [[NSDictionary alloc] initWithContentsOfFile:dataPath];
    
    int lvlcount = [tempDict count];
    int pageNum = [tempDict count]/PER_PAGE_LVL_NUM+1;
    for (int i=0; i<lvlcount; i++) {
        
        UIView *lvlView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    }
    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
