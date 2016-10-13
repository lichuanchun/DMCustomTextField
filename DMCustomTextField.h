//
//  DMCustomTextField.h
//
//  Created by chuanchun li on 16/10/12.
//  Copyright © 2016年 chuanchun li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMCustomTextField : UITextField

/** 占位符字体颜色 */
@property (nonatomic, strong) UIColor *placeColor;
/** 占位符字体大小 */
@property (nonatomic, assign) CGFloat placeFontSize;
/** 左视图 */
@property (nonatomic, weak) UILabel *leftViewLabel;

/**
 *  便利构造器
 *
 *  @param fontSize      输入的字体大小
 *  @param colorStr      输入的字体颜色
 *  @param textAlignment 输入的文本样式
 *  @param placeStr      占位符的名字
 */
+ (DMCustomTextField *)customTextFieldWithFontSize:(CGFloat)fontSize colorStr:(NSString *)colorStr textAlignment:(NSTextAlignment)textAlignment placeStr:(NSString *)placeStr;

/**
 *  自定义左视图
 *
 *  @param title         名字
 *  @param fontSize      字体大小
 *  @param colorStr      字体颜色
 *  @param textAlignment 文本样式
 */
- (UILabel *)customLeftViewWithTitle:(NSString *)title fontSize:(CGFloat)fontSize colorStr:(NSString *)colorStr textAlignment:(NSTextAlignment)textAlignment;

@end
