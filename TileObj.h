//
//  TileObj.h
//  开心填字
//
//  Created by user on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TileObj : NSObject{
    
    UIButton *tileLabel;
    UILabel *boxword;
    NSString *eStr;
    NSString *cStr;
    NSString *introduce;
    BOOL isEmpty;
    NSString *curStr;
}
@property(nonatomic,strong) UIButton *tileLabel;
@property(nonatomic,strong) UILabel *boxword;
@property(nonatomic,strong) NSString *eStr;
@property(nonatomic,strong) NSString *curStr;
//@property(nonatomic,assign) int wordsGroup;



@end
