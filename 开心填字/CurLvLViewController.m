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
    }
    return self;
}


// set the label and background color when the view has finished loading
- (void)viewDidLoad
{

    
}

@end
