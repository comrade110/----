//
//  LevelViewController.m
//  开心填字
//
//  Created by user on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LevelViewController.h"
#import "CurLvLViewController.h"


@interface LevelViewController ()

@end

@implementation LevelViewController

@synthesize viewControllers;

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
//    kNumberOfPages = [tempDict count]/PER_PAGE_LVL_NUM+1;
    kNumberOfPages = 5;
    for (int i=0; i<lvlcount; i++) {
        
//        UIView *lvlView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    }
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < kNumberOfPages; i++)
    {
		[controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    // a page is the width of the scroll view
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,100, 320, 300)];
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * kNumberOfPages, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    
    [self.view addSubview:scrollView];
    
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(120, 380, 120, 50)];
    pageControl.numberOfPages = kNumberOfPages;
    pageControl.currentPage = 0;
    [pageControl addTarget:self action:@selector(changePage) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pageControl];
    
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    //
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];    
    
}

- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    if (page >= kNumberOfPages)
        return;
    
    // replace the placeholder if necessary
    CurLvLViewController *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        controller = [[CurLvLViewController alloc] initWithPageNumber:page];
        
        controller.view.backgroundColor = [UIColor colorWithRed:10*page green:20*page blue:30*page alpha:1];
        [viewControllers replaceObjectAtIndex:page withObject:controller];
        
    }
    // add the controller's view to the scroll view
    if (controller.view.superview == nil)
    {
        NSLog(@"sdasd,page:%d",page);
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        float colorParam = (float)page;
        controller.view.backgroundColor = [UIColor colorWithRed:40*colorParam/255 green:20*colorParam/255 blue:40*colorParam/255 alpha:1];
        [scrollView addSubview:controller.view];
//        controller.numberImage.image = [UIImage imageNamed:[numberItem valueForKey:ImageKey]];
//        controller.numberTitle.text = [numberItem valueForKey:NameKey];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed)
    {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

- (void)changePage
{
    int page = pageControl.currentPage;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
	// update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
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
