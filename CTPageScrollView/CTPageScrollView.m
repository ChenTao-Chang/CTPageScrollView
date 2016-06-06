//
//  CTPageScrollView.m
//  CTPageScrollViewDemo
//
//  Created by changchentao on 16/6/6.
//  Copyright © 2016年 changchentao. All rights reserved.
//

#import "CTPageScrollView.h"

@interface CTPageScrollView ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) NSTimer *timer;

@end


@implementation CTPageScrollView

#pragma mark -- init methods
+ (instancetype)pageScrollView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        [self setup];
    }
    return self;
}

- (void)awakeFromNib{
    [self setup];
}

- (void)setup{
    [self startTimer];
}



- (void)setImages:(NSArray *)images{
    
    _images = images;
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i = 0; i < images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:images[i]];
        [self.scrollView addSubview:imageView];
    }
    
    self.pageControl.numberOfPages = _images.count;
    self.pageControl.hidesForSinglePage = YES;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat scrollW = self.scrollView.frame.size.width;
    CGFloat scrollH = self.scrollView.frame.size.height;
    
    self.scrollView.contentSize = CGSizeMake(self.images.count * scrollW, 0);
    
    for (int i = 0; i < self.images.count; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        imageView.frame = CGRectMake(i * scrollW, 0, scrollW, scrollH);
    }
}

- (void)setPageControlOtherPageColor:(UIColor *)otherPageColor currentPageCplor:(UIColor *)currentPageColor{
    
    self.pageControl.pageIndicatorTintColor = otherPageColor;
    self.pageControl.currentPageIndicatorTintColor = currentPageColor;
}


#pragma mark -- timer control
- (void)startTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(srollToNextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}

/**
 *  next page
 */
- (void)srollToNextPage{
    
    NSInteger page = self.pageControl.currentPage + 1;
    
    if (page == self.pageControl.numberOfPages) {
        page = 0;
    }
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = page * self.scrollView.frame.size.width;
    
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    self.pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}

@end
