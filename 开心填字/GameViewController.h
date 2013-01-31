//
//  GameViewController.h
//  开心填字
//
//  Created by user on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TileObj.h"
#import "JSONKit.h"

@interface GameViewController : UIViewController{
    
    NSString *str[10][10]; 
    NSString *cnStr[10][10];
    NSInteger perRow;
    NSString *landscapeIntro;
    NSString *portraitIntro;
    UILabel *levelwords[10][10];
    NSString *userInputStr[10][10];
    NSInteger tipCount;
    NSMutableArray *wordsArr;
    NSMutableArray *curXArr;
    NSMutableArray *curYArr;
    NSInteger selectedTag;
    BOOL isPortrait;
    CGRect tempRect;
}
@property(nonatomic,strong) IBOutlet UILabel *ll;

@property(nonatomic,strong) IBOutlet UILabel *pl;


@property(nonatomic,strong) IBOutlet UIButton *key_q;
@property(nonatomic,strong) IBOutlet UIButton *key_w;
@property(nonatomic,strong) IBOutlet UIButton *key_e;
@property(nonatomic,strong) IBOutlet UIButton *key_r;
@property(nonatomic,strong) IBOutlet UIButton *key_t;
@property(nonatomic,strong) IBOutlet UIButton *key_y;
@property(nonatomic,strong) IBOutlet UIButton *key_o;
@property(nonatomic,strong) IBOutlet UIButton *key_p;
@property(nonatomic,strong) IBOutlet UIButton *key_a;
@property(nonatomic,strong) IBOutlet UIButton *key_s;
@property(nonatomic,strong) IBOutlet UIButton *key_d;
@property(nonatomic,strong) IBOutlet UIButton *key_f;
@property(nonatomic,strong) IBOutlet UIButton *key_g;
@property(nonatomic,strong) IBOutlet UIButton *key_h;
@property(nonatomic,strong) IBOutlet UIButton *key_j;
@property(nonatomic,strong) IBOutlet UIButton *key_k;
@property(nonatomic,strong) IBOutlet UIButton *key_l;
@property(nonatomic,strong) IBOutlet UIButton *key_z;
@property(nonatomic,strong) IBOutlet UIButton *key_x;
@property(nonatomic,strong) IBOutlet UIButton *key_c;
@property(nonatomic,strong) IBOutlet UIButton *key_b;
@property(nonatomic,strong) IBOutlet UIButton *key_n;
@property(nonatomic,strong) IBOutlet UIButton *key_m;

-(IBAction)btn_a_Press:(id)sender;
-(void)wordInput:(id)sender;
@end
