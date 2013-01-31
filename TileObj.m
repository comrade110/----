//
//  TileObj.m
//  开心填字
//
//  Created by user on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TileObj.h"

@implementation TileObj

@synthesize tileLabel,eStr,curStr;

- (id)init
{
    self = [super init];
    if (self) {
        self.tileLabel = [[UIButton alloc] init];
        
        self.tileLabel.backgroundColor = [UIColor whiteColor];

    }
    return self;
}

@end
