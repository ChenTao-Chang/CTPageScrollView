//
//  CTPageScrollView.h
//  CTPageScrollViewDemo
//
//  Created by changchentao on 16/6/6.
//  Copyright © 2016年 changchentao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTPageScrollView : UIView

/** 图片数组 */
@property(nonatomic, strong) NSArray *images;

+ (instancetype)pageScrollView;

- (void)setPageControlOtherPageColor:(UIColor *)otherPageColor
                    currentPageCplor:(UIColor *)currentPageColor;

@end
