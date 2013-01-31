//
//  GameViewController.m
//  开心填字
//
//  Created by user on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"

#define kDuration 0.7   // 动画持续时间(秒)
 
static NSMutableArray *tipXArr;
static NSMutableArray *tipYArr;
static NSArray *tipXdataArr;
static NSArray *tipYdataArr;

@implementation GameViewController

@synthesize key_a,key_b,key_c,key_d,key_e,key_f,key_g,key_h,key_j,key_k,key_l,key_m;
@synthesize key_n,key_o,key_p,key_q,key_r,key_s,key_t,key_w,key_x,key_y,key_z;
@synthesize ll,pl;

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
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *dataPath = [path stringByAppendingPathComponent:@"en.lproj/Localizable.strings"];
    NSDictionary *tempDict = [[NSDictionary alloc] initWithContentsOfFile:dataPath];
    NSLog(@"tempDict count:%d",[tempDict count]);
    
    NSDictionary *dataDic = [[tempDict objectForKey:@"level0"] objectFromJSONString];
    
  //  NSLog(@"%@",dataDic);
    
    NSString *chineseStr = [dataDic objectForKey:@"answer"];
    NSString *enStr = [dataDic objectForKey:@"letter"];
    NSString *tipX=[dataDic objectForKey:@"tipX"];
    NSString *tipY=[dataDic objectForKey:@"tipY"];
    tipXdataArr = [[NSArray alloc] init];
    tipYdataArr = [[NSArray alloc] init];
    tipXdataArr = [tipX componentsSeparatedByString:@"|"];
    tipYdataArr = [tipY componentsSeparatedByString:@"|"];
    
    perRow = [[dataDic objectForKey:@"lines"] intValue];
    NSArray *enArr = [enStr componentsSeparatedByString:@","];
    
    NSLog(@"cnArr:%d", [chineseStr length]);
    
    int i,j,r1=0;
    for (i=0; i<perRow; i++) {
        for (j=0; j<perRow; j++) {
            NSString *nowStr = [chineseStr substringWithRange:NSMakeRange(r1,1)];
            NSString *nowEnStr = [enArr objectAtIndex:i*perRow+j];
            if (r1<perRow*perRow) {
                r1++;
            }
            if ([nowStr isEqualToString:@"　"]) {
                
                cnStr[i][j] = nil;
            }else {
                cnStr[i][j] = nowStr;
            }
            if ([nowEnStr isEqualToString:@""]) {
                str[i][j] = nil;
            }else {
                str[i][j] = nowEnStr;
            }
        }
    }
    
    
    tipXArr = [NSMutableArray array];
    tipYArr = [NSMutableArray array];
    [self findXPrompt];
    [self findYPrompt];
    
//    NSLog(@"%@",tipXArr);
//    
//    NSLog(@"%d", userInputStr[0][0].length);
    
    
    
    for (int i=0; i<perRow; i++) {        
        for (int j=0; j<perRow; j++) {
            TileObj *tileObj = [[TileObj alloc] init];
            userInputStr[i][j] = @"";
            
            tileObj.tileLabel.tag = i*perRow+j+1000;   //  标签区分不同格子
            
            NSLog(@"%d",tileObj.tileLabel.tag);
            tileObj.tileLabel.frame = CGRectMake(21+31*j, 53+31*i, 28, 28); //  格子距离
            
            [tileObj.tileLabel setTitle:userInputStr[i][j] forState:UIControlStateNormal];
            
            [tileObj.tileLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [tileObj.tileLabel addTarget:self action:@selector(wordInput:) forControlEvents:UIControlEventTouchUpInside];
            
            if (str[i][j]==nil) {
                tileObj.tileLabel.userInteractionEnabled = NO;
                [tileObj.tileLabel setBackgroundColor:[UIColor grayColor]];
            }
            
            [self.view addSubview:tileObj.tileLabel];
        }
    }
    
    //  初始化提示
    
    ll.text = @"点击方阵中的空白格子之后按提示使用下方";
    pl.text = @"键盘输入词语的拼音首字母，答案随即出现。";
    
    tempRect = pl.frame;
	
}


-(void)findXPrompt{
        
    for (int i=0; i<perRow; i++) {
        
        NSMutableArray *tempArr = [[NSMutableArray alloc] init];
        for (int j=0; j<perRow; j++) {
            if (str[i][j]==nil) {
                [tempArr addObject:[NSNumber numberWithInt:i*perRow+j]];
            }
        }
//        NSLog(@"%d~~",[tempArr count]);
        for (int k=0; k<[tempArr count]+1; k++) {
            NSInteger c;
            if (k==0) {
                
                c = [[tempArr objectAtIndex:0] intValue]-i*perRow+1;
//                NSLog(@"c::%d",c);
            }
            else if(k>0&&k<[tempArr count]){
                
                c = [[tempArr objectAtIndex:k] intValue]-[[tempArr objectAtIndex:k-1] intValue];
//                NSLog(@"c::::%d",c);
            }else if(k==[tempArr count]){
                c=(i+1)*perRow-[[tempArr lastObject] intValue];
            }
            if (c>2) {
                NSMutableArray *rows=[NSMutableArray array];
                for (int q=0; q<c-1; q++) {
                    if (k==0) {
                        [rows addObject:[NSNumber numberWithInt:i*perRow+q]];
                    }else{
                        [rows addObject:[NSNumber numberWithInt:[[tempArr objectAtIndex:k-1] intValue]+q+1]];
                    }
                }
                [tipXArr addObject:rows];
            }
        }
    }
}
-(void)findYPrompt{
    for (int i=0; i<perRow; i++) {
        
        NSMutableArray *tempArr = [[NSMutableArray alloc] init];
        for (int j=0; j<perRow; j++) {
            if (str[j][i]==nil) {
                [tempArr addObject:[NSNumber numberWithInt:j*perRow+i]];
            }
        }
        for (int k=0; k<[tempArr count]+1; k++) {
            NSInteger c;
            if (k==0) {
                
                c = (([[tempArr objectAtIndex:0] intValue]-i)/perRow)+1;
            }
            else if(k>0&&k<[tempArr count]){
                
                c = ([[tempArr objectAtIndex:k] intValue]-[[tempArr objectAtIndex:k-1] intValue])/perRow;
            }else if(k==[tempArr count]){
                c=(perRow*perRow+i-[[tempArr lastObject] intValue])/perRow;
            }
            if (c>2) {
                NSMutableArray *rows=[NSMutableArray array];
                for (int q=0; q<c-1; q++) {
                    if (k==0) {
                        
                        [rows addObject:[NSNumber numberWithInt:q*perRow+i]];
                    }else {
                        [rows addObject:[NSNumber numberWithInt:[[tempArr objectAtIndex:k-1] intValue]+(q+1)*perRow]];
                    }
                }
                [tipYArr addObject:rows];
            }
        }
    }
}

//-(void)findPrompt2:(int)x withY:(int)y{
//    
//    for (int i =0; i<perRow; i++) {
//        if (str[x][y]!=nil&&str[x][y+1]!=nil&&y+1<perRow) {
//            
//        }
//    }
//}




-(IBAction)btn_a_Press:(id)sender{

    if (!selectedTag) return;
    
    UIButton *button = (UIButton*)sender;
    
    NSInteger userX = (selectedTag-1000)/perRow;
    NSInteger userY = (selectedTag-1000)%perRow;
    
    userInputStr[userX][userY]=button.titleLabel.text;
    
    [(UIButton*)[self.view viewWithTag:selectedTag] setTitle:button.titleLabel.text forState:UIControlStateNormal];
    
    NSInteger isNeedAnimat1 = 0;
    NSInteger isNeedAnimat2 = 0;
    
    if ([str[userX][userY] isEqualToString:button.titleLabel.text]) {
        NSLog(@"userInputStr[%d][%d]:%@",userX,userY,userInputStr[userX][userY]);
        if ([curXArr count]>0) {
            for (NSNumber *num in curXArr) {
                NSInteger x = [num intValue]/perRow;    
                NSInteger y = [num intValue]%perRow;    
                NSLog(@"%d--%d",x,y);
                if (![userInputStr[x][y] isEqualToString:str[x][y]]) {
                    isNeedAnimat1++;
                    
                    NSLog(@"%@~~%@",userInputStr[x][y],str[x][y]);
                }
            }
            NSLog(@"isNeedAnimat:%d",isNeedAnimat1);
            for (NSNumber *num in curXArr) {
                int x = [num intValue]/perRow;
                int y = [num intValue]%perRow;
                if (isNeedAnimat1 == 0) {
                    [(UIButton*)[self.view viewWithTag:[num intValue]+1000] setTitle:cnStr[x][y] forState:UIControlStateNormal];
                    [self cnWordAppearWithX:x withY:y];
                    
                    [(UIButton*)[self.view viewWithTag:selectedTag] 
                     setTitle:cnStr[(selectedTag-1000)/perRow][(selectedTag-1000)%perRow] 
                     forState:UIControlStateNormal]; 
                    
                    [self cnWordAppearWithX:(selectedTag-1000)/perRow withY:(selectedTag-1000)%perRow];
                }
            }

        }
        
        if ([curYArr count]>0) {
            for (NSNumber *num in curYArr) {
                int x = [num intValue]/perRow;
                int y = [num intValue]%perRow;
                if (![userInputStr[x][y] isEqualToString:str[x][y]]) {
                    isNeedAnimat2++;
                }
            }
            for (NSNumber *num in curYArr) {
                int x = [num intValue]/perRow;
                int y = [num intValue]%perRow;
                if (isNeedAnimat2 == 0) {
                    
                    [(UIButton*)[self.view viewWithTag:[num intValue]+1000] setTitle:cnStr[x][y] forState:UIControlStateNormal];
                    
                    [self cnWordAppearWithX:x withY:y];
                    [(UIButton*)[self.view viewWithTag:selectedTag] 
                     setTitle:cnStr[userX][userY] 
                     forState:UIControlStateNormal]; 
                    
                    [self cnWordAppearWithX:userX withY:userY];
                }
            }
            
        }
    }
    if (userY!=perRow-1 && [userInputStr[userX][userY+1] isEqualToString:@""] && str[userX][userY+1]!=nil && !isPortrait) {
        selectedTag++;
        [self wordInput:[self.view viewWithTag:selectedTag]];
        return;
    }
    if (userX!=perRow-1 && [userInputStr[userX+1][userY] isEqualToString:@""] && str[userX+1][userY]!=nil) {
        isPortrait = YES;
        selectedTag = selectedTag +perRow;
        [self wordInput:[self.view viewWithTag:selectedTag]];
        return;
    }else {
        isPortrait = NO;
    }
}

-(void)wordInput:(id)sender{
    UIButton *button = (UIButton*)sender;
    
    selectedTag = button.tag;
    
    NSLog(@"button.tag:%d",button.tag);
    NSInteger x =(selectedTag-1000)/perRow;
    NSInteger y =(selectedTag-1000)%perRow;
    
    for (int i=0; i<perRow; i++) {
        for (int j=0; j<perRow; j++) {
            if (str[i][j]!=nil) {
                [[self.view viewWithTag:1000+i*perRow+j] setBackgroundColor:[UIColor whiteColor]];

            }
        }
    }
    NSInteger nowSel = selectedTag-1000;
    for (int i=0;i<[tipXArr count];i++) {
        
        for (NSNumber *num in [tipXArr objectAtIndex:i]) {
            if ([num intValue] == nowSel) {
                landscapeIntro = [tipXdataArr objectAtIndex:i];
                i=[tipXArr count];
            }
        }
    }
    NSLog(@"nowSel:%d",nowSel);
    for (int i=0;i<[tipYArr count];i++) {
        
        for (NSNumber *num in [tipYArr objectAtIndex:i]) {
            if ([num intValue] == nowSel) {
                portraitIntro = [tipYdataArr objectAtIndex:i];
                i=[tipYArr count];
            }
        }
    }
    NSLog(@"l:%@\np:%@",landscapeIntro,portraitIntro);
    [button setBackgroundColor:[UIColor orangeColor]];
    curXArr = [NSMutableArray array];
    curYArr = [NSMutableArray array];
    [self checkIsGroupwithTop:x withY:y];
    [self checkIsGroupwithBottom:x withY:y];
    [self checkIsGroupwithLeft:x withY:y];
    [self checkIsGroupwithRight:x withY:y];
    
    

    if (landscapeIntro == nil) {
        ll.hidden = YES;
        pl.hidden = NO;
        pl.frame = ll.frame;
        pl.text = [NSString stringWithFormat:@"纵向：%@",portraitIntro];
    }else if (portraitIntro == nil) {
        pl.hidden = YES;
        ll.hidden = NO;
        ll.text = [NSString stringWithFormat:@"横向：%@",landscapeIntro];
    }else{
        ll.hidden = NO;
        pl.hidden = NO;
        pl.frame = tempRect;
        ll.text = [NSString stringWithFormat:@"横向：%@",landscapeIntro];
        pl.text = [NSString stringWithFormat:@"纵向：%@",portraitIntro];
    
    }
    landscapeIntro = nil;
    portraitIntro = nil;
    
}
-(void)cnWordAppearWithX:(int)x withY:(int)y{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:kDuration];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:[self.view viewWithTag:x*perRow+y+1000] cache:YES];
    
    [self.view exchangeSubviewAtIndex:x*perRow+y+1000 withSubviewAtIndex:x*perRow+y+1000];
    
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用某个方法
    //[UIView setAnimationDidStopSelector:@selector(animationFinished:)];
    [UIView commitAnimations];

}

-(void)checkIsGroupwithTop:(int)x withY:(int)y{
    if (str[x-1][y]!=nil && x!=0) {
        [[self.view viewWithTag:(x-1)*perRow+y+1000] setBackgroundColor:[UIColor yellowColor]];
        if (curYArr) {
            [curYArr addObject:[NSNumber numberWithInt:(x-1)*perRow+y]];
        }
        [self checkIsGroupwithTop:x-1 withY:y];
    }
}
-(void)checkIsGroupwithBottom:(int)x withY:(int)y{
    if (str[x+1][y] !=nil && x!=perRow-1) {
        [[self.view viewWithTag:(x+1)*perRow+y+1000] setBackgroundColor:[UIColor yellowColor]];
        if (curYArr) {
            [curYArr addObject:[NSNumber numberWithInt:(x+1)*perRow+y]];
        }
        [self checkIsGroupwithBottom:x+1 withY:y];
    }
}
-(void)checkIsGroupwithLeft:(int)x withY:(int)y{
    if (str[x][y-1]!=nil && y!=0) {
        [[self.view viewWithTag:x*perRow+y+999] setBackgroundColor:[UIColor yellowColor]];
        if (curXArr) {
            [curXArr addObject:[NSNumber numberWithInt:x*perRow+y-1]];
        }
        [self checkIsGroupwithLeft:x withY:y-1];
    }
}
-(void)checkIsGroupwithRight:(int)x withY:(int)y{
    if (str[x][y+1] !=nil && y!=perRow-1) {
        [[self.view viewWithTag:x*perRow+y+1001] setBackgroundColor:[UIColor yellowColor]];
        if (curXArr) {
            [curXArr addObject:[NSNumber numberWithInt:x*perRow+y+1]];
        }
        [self checkIsGroupwithRight:x withY:y+1];
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
