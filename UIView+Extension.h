//
//  UIView+Extension.h
//  Copyright (c) 2015年 FST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

/** 更改了一个图层的AnchorPoint,那么这个图层会发送位移,发生位移之后,将位移修复回来 */
- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view;

@end
