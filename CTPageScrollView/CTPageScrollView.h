//
//  CTPageScrollView.h
//  CTPageScrollViewDemo
//
//  Created by changchentao on 16/6/6.
//  Copyright © 2016年 changchentao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PageControlLocation){
    PageControlLocationLeft         = 0,
    PageControlLocationCenter       = 1 << 0,
    PageControlLocationRight        = 1 << 1,
};

typedef void(^imageViewTapBlock)(NSInteger index);

@interface CTPageScrollView : UIView

/** 图片数组 */
@property (nonatomic, strong) NSArray *images;
/** pageControl位置 */
@property(nonatomic, assign) PageControlLocation pageControlLoacation;

@property(nonatomic, copy)  imageViewTapBlock imageViewTapBlock;

+ (instancetype)pageScrollView;

- (void)setPageControlOtherPageColor:(UIColor *)otherPageColor
                    currentPageCplor:(UIColor *)currentPageColor;

@end
