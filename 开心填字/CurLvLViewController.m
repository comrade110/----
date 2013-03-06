//
//  CurLvLViewController.m
//  cpuzz
//
//  Created by user on 13-2-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "CurLvLViewController.h"

@implementation CurLvLViewController


// load the view nib and initialize the pageNumber ivar
- (id)initWithPageNumber:(int)page
{
    if (self = [super init])
    {
        pageNumber = page;
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSString *dataPath = [path stringByAppendingPathComponent:@"en.lproj/Localizable.strings"];
        NSDictionary *tempDict = [[NSDictionary alloc] initWithContentsOfFile:dataPath];
        NSLog(@"tempDict count:%d",[tempDict count]);
    }
    return self;
}


// set the label and background color when the view has finished loading
- (void)viewDidLoad
{
    for (int i=0; i<PER_PAGE_LVL_NUM; i++) {
        
        UIView *lvlBoxView = [[UIView alloc] initWithFrame:CGRectMake((i%4)*70, (i/4)*70, 60, 60)];
        lvlBoxView.tag = i+PAGE_UIVIEW_TAG;
        lvlBoxView.backgroundColor = [UIColor colorWithRed:0.1 green:0.6 blue:0.4 alpha:0.8];
        UIButton *lab = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        lab.tag = i+1;
        [lab setTitle:[NSString stringWithFormat:@"%d",pageNumber*PER_PAGE_LVL_NUM+i+1] forState:UIControlStateNormal];
        [lab addTarget:self action:@selector(selectLvl:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:lvlBoxView];
        [lvlBoxView addSubview:lab];
    }
    
}

-(void)select:(id)sender
{


}



@end
