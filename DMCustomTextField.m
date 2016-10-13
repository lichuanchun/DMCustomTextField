//
//  DMCustomTextField.m
//
//  Created by chuanchun li on 16/10/12.
//  Copyright © 2016年 chuanchun li. All rights reserved.
//

#import "DMCustomTextField.h"
#import "UIColor+Util.h"
#import "UIView+Extension.h"

/** 宽 */
#define WIDTH [UIScreen mainScreen].bounds.size.width
/** 高 */
#define HEIGHT [UIScreen mainScreen].bounds.size.height
/** 字体 */
#define FONT(B) [UIFont systemFontOfSize:FONTSIZE(B)]
/** 颜色 */
#define COLOR(A) [UIColor colorWithHexString:A]
/** 适配宽度 */
#define DISTANCESIZE(size) WIDTH * (size / 375.0)
/** 适配高度 */
#define DISTANCEHEIGHTSIZE(size) HEIGHT * (size / 667.0)
/** 适配字体大小 */
#define FONTSIZE(size) WIDTH > 375 ? size * (414.0 / 375.0) : (WIDTH == 375 ? size  : (size / (375.0 / 320.0)))

@interface DMCustomTextField ()

/** 占位label */
@property (nonatomic, weak) UILabel *placeLabel;
/** 占位字符 */
@property (nonatomic, copy) NSString *placeStr;
/** 默认的左视图，如果没有调用创建左视图的方法，会有一个默认的左视图 */
@property (nonatomic, weak) UIView *leftView_default;

@end

@implementation DMCustomTextField

#pragma mark - 通知
// 注册通知
- (void)registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditingNotification:) name:UITextFieldTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditingNotification:) name:UITextFieldTextDidEndEditingNotification object:self];
}
// 移除通知或代理
- (void)removeNotificationOrDelegate
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidEndEditingNotification object:self];
}
// 开始编辑回调
- (void)beginEditingNotification:(NSNotification *)notifi
{
    self.placeLabel.hidden = YES;
}
// 结束编辑回调
- (void)endEditingNotification:(NSNotification *)notifi
{
    UITextField *textField = (UITextField *)notifi.object;
    if (![textField.text isEqualToString:@""]) {
        self.placeLabel.hidden = YES;
    }else {
        self.placeLabel.hidden = NO;
    }
}

#pragma mark - 创建自定义的textField
+ (DMCustomTextField *)customTextFieldWithFontSize:(CGFloat)fontSize colorStr:(NSString *)colorStr textAlignment:(NSTextAlignment)textAlignment placeStr:(NSString *)placeStr
{
    return [[DMCustomTextField alloc] initWithFontSize:(CGFloat)fontSize colorStr:(NSString *)colorStr textAlignment:(NSTextAlignment)textAlignment placeStr:(NSString *)placeStr];
}
- (instancetype)initWithFontSize:(CGFloat)fontSize colorStr:(NSString *)colorStr textAlignment:(NSTextAlignment)textAlignment placeStr:(NSString *)placeStr
{
    self = [super init];
    if (self) {
        [self registerNotification];
        self.font = FONT(fontSize);
        self.textColor = COLOR(colorStr);
        self.textAlignment = textAlignment;
        // 占位label
        self.placeStr = placeStr;
        UILabel *placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(DISTANCESIZE(15.0), 0, 0, 0)];
        placeLabel.text = placeStr;
        self.placeLabel = placeLabel;
        [self addSubview:placeLabel];
        // 默认leftView
        UIView *leftView_default = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DISTANCESIZE(5.0), 0)];
        self.leftView = leftView_default;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftView_default = leftView_default;
    }
    return self;
}

#pragma mark - 创建自定义的左视图（可不调用，如果需要左视图在调用）
- (UILabel *)customLeftViewWithTitle:(NSString *)title fontSize:(CGFloat)fontSize colorStr:(NSString *)colorStr textAlignment:(NSTextAlignment)textAlignment
{
    CGSize size = [self heightNormalForString:title width:1000 height:1000 size:fontSize];
    UILabel *leftViewLabel = [[UILabel alloc] init];
    leftViewLabel.frame = CGRectMake(0, 0, size.width + DISTANCESIZE(30.0), self.height);
    leftViewLabel.text = title;
    leftViewLabel.font = FONT(fontSize);
    leftViewLabel.textColor = COLOR(colorStr);
    leftViewLabel.textAlignment = textAlignment;
    return leftViewLabel;
}

#pragma mark - setter方法
- (void)setLeftViewLabel:(UILabel *)leftViewLabel
{
    _leftViewLabel = leftViewLabel;
    _leftView_default.hidden = YES;
    self.leftView = leftViewLabel;
    self.leftViewMode = UITextFieldViewModeAlways;
    _placeLabel.x = CGRectGetMaxX(_leftViewLabel.frame);
}
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _leftView_default.height = frame.size.height;
    _leftViewLabel.height = frame.size.height;
    _placeLabel.height = frame.size.height;
}
- (void)setPlaceFontSize:(CGFloat)placeFontSize
{
    _placeFontSize = placeFontSize;
    _placeLabel.font = FONT(placeFontSize);
    CGSize placeSize = [self heightNormalForString:self.placeStr width:1000 height:1000 size:FONTSIZE(placeFontSize)];
    _placeLabel.width = placeSize.width;
}
- (void)setPlaceColor:(UIColor *)placeColor
{
    _placeColor = placeColor;
    _placeLabel.textColor = placeColor;
}

#pragma mark - 计算字符串的宽高
- (CGSize)heightNormalForString:(NSString *)aString width:(CGFloat)width height:(CGFloat)height size:(CGFloat)size
{
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:size]};
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size;
}

#pragma mark - 销毁
- (void)dealloc
{
    [self removeNotificationOrDelegate];
}




@end
