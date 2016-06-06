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

#pragma mark -- create components
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

/**
 *  init
 */
- (void)setup{
    [self startTimer];
}

/**
 *  pageControl loacaiotn
 */
- (void)setPageControlLoacation:(PageControlLocation)pageControlLoacation{
    switch (pageControlLoacation) {
        case PageControlLocationLeft:
            
            break;
            
        case PageControlLocationCenter:
            
            break;
            
        case PageControlLocationRight:
            
            break;
        default:
            break;
    }
}

/**
 *  add images
 *
 *  @param images imagesArray
 */
- (void)setImages:(NSArray *)images{
    
    _images = images;
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i = 0; i < images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:images[i]];
        [self.scrollView addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapActon:)];
        [imageView addGestureRecognizer:tap];
    }
    
    self.pageControl.numberOfPages = _images.count;
    self.pageControl.hidesForSinglePage = YES;
}

/**
 *  tap action
 */
- (void)imageViewTapActon:(UITapGestureRecognizer *)tap{
    if (self.imageViewTapBlock) {
        self.imageViewTapBlock(self.pageControl.currentPage);
    }
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

/**
 *  set  pageControl's  color
 *
 *  @param otherPageColor
 *  @param currentPageColor
 */
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
