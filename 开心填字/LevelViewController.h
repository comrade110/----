//
//  LevelViewController.h
//  开心填字
//
//  Created by user on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONKit.h"

@interface LevelViewController : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    NSMutableArray *viewControllers;
    int kNumberOfPages;
    NSArray *contentList;
    
    // To be used when scrolls originate from the UIPageControl
    BOOL pageControlUsed;
}
@property(nonatomic,retain) NSMutableArray *viewControllers;

@end
