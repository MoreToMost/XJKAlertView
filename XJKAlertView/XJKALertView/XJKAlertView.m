//
//  XJKAlertView.m
//  XJKAlertView
//
//  Created by 徐靖凯 on 2017/8/16.
//  Copyright © 2017年 徐靖凯. All rights reserved.
//

#import "XJKAlertView.h"

#define AlertW 280.0
#define AlertSpace 10.0

@interface XJKAlertView ()

@property (nonatomic, strong) UIView * alertView;

@property (nonatomic, strong) UILabel * titleLabel;

@property (nonatomic, strong) UILabel * messageLabel;

@property (nonatomic, strong) UIButton * sureButton;

@property (nonatomic, strong) UIButton * cancleButton;

@property (nonatomic, strong) UIView * lineView;

@property (nonatomic, strong) UIView * verLineView;


@end

@implementation XJKAlertView

-(instancetype)initWithTitle:(NSString *)title Message:(NSString *)message sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle
{
    if (self == [super init])
    {
        self.frame = [UIScreen mainScreen].bounds;
        //        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.6];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius = 5.0;
        self.alertView.frame = CGRectMake(0, 0, AlertW, 100);
        self.alertView.layer.position = self.center;
        
        if (title)
        {
            self.titleLabel = [self getAdaptiveLabelWithFrame:CGRectMake(2 * AlertSpace, 2 * AlertSpace, AlertW - 4 * AlertSpace, 20) andText:title andIsTitle:YES];
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            [self.alertView addSubview:self.titleLabel];
            
            CGFloat titleW = self.titleLabel.bounds.size.width;
            CGFloat titleH = self.titleLabel.bounds.size.height;
            self.titleLabel.frame = CGRectMake((AlertW - titleW) / 2, 2 * AlertSpace, titleW, titleH);
        }
        
        if (message)
        {
            self.messageLabel = [self getAdaptiveLabelWithFrame:CGRectMake(AlertSpace, CGRectGetMaxY(self.titleLabel.frame) + AlertSpace, AlertW - 2 * AlertSpace, 20) andText:message andIsTitle:NO];
            self.messageLabel.textAlignment = NSTextAlignmentCenter;
            [self.alertView addSubview:self.messageLabel];
            
            CGFloat messageW = self.messageLabel.bounds.size.width;
            CGFloat messageH = self.messageLabel.bounds.size.height;
            self.messageLabel.frame = self.titleLabel ? CGRectMake((AlertW - messageW) / 2, CGRectGetMaxY(self.titleLabel.frame) + AlertSpace, messageW, messageH) : CGRectMake((AlertW - messageW) / 2, 2 * AlertSpace, messageW, messageH);
        }
        
        self.lineView = [[UIView alloc] init];
        self.lineView.frame = self.messageLabel ? CGRectMake(0, CGRectGetMaxY(self.messageLabel.frame) + 2 * AlertSpace, AlertW, 1) : CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame) + 2 * AlertSpace, AlertW, 1);
        self.lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
        [self.alertView addSubview:self.lineView];
        
        if (cancleTitle && sureTitle)
        {
            self.cancleButton = [UIButton buttonWithType:UIButtonTypeSystem];
            self.cancleButton.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), (AlertW-1)/2, 40);
            [self.cancleButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.cancleButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.cancleButton setTitle:cancleTitle forState:UIControlStateNormal];
            self.cancleButton.tag = 1;
            [self.cancleButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cancleButton.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.cancleButton.bounds;
            maskLayer.path = maskPath.CGPath;
            self.cancleButton.layer.mask = maskLayer;
            [self.alertView addSubview:self.cancleButton];
        }
        
        if (cancleTitle && sureTitle)
        {
            self.verLineView = [[UIView alloc] init];
            self.verLineView.frame = CGRectMake(CGRectGetMaxX(self.cancleButton.frame), CGRectGetMaxY(self.lineView.frame), 1, 40);
            self.verLineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
            [self.alertView addSubview:self.verLineView];
        }
        
        if(sureTitle && cancleTitle)
        {
            self.sureButton = [UIButton buttonWithType:UIButtonTypeSystem];
            self.sureButton.frame = CGRectMake(CGRectGetMaxX(self.verLineView.frame), CGRectGetMaxY(self.lineView.frame), (AlertW-1)/2+1, 40);
            [self.sureButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.sureButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.sureButton setTitle:sureTitle forState:UIControlStateNormal];
            self.sureButton.tag = 2;
            [self.sureButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.sureButton.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.sureButton.bounds;
            maskLayer.path = maskPath.CGPath;
            self.sureButton.layer.mask = maskLayer;
            [self.alertView addSubview:self.sureButton];
        }
        
        //只有取消按钮
        if (cancleTitle && !sureTitle)
        {
            self.cancleButton = [UIButton buttonWithType:UIButtonTypeSystem];
            self.cancleButton.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), AlertW, 40);
            [self.cancleButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.cancleButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.cancleButton setTitle:cancleTitle forState:UIControlStateNormal];
            self.cancleButton.tag = 1;
            [self.cancleButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cancleButton.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.cancleButton.bounds;
            maskLayer.path = maskPath.CGPath;
            self.cancleButton.layer.mask = maskLayer;
            [self.alertView addSubview:self.cancleButton];
        }
        
        //只有确定按钮
        if (sureTitle && !cancleTitle)
        {
            self.sureButton = [UIButton buttonWithType:UIButtonTypeSystem];
            self.sureButton.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), AlertW, 40);
            [self.sureButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.sureButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.sureButton setTitle:sureTitle forState:UIControlStateNormal];
            self.sureButton.tag = 2;
            [self.sureButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.sureButton.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.sureButton.bounds;
            maskLayer.path = maskPath.CGPath;
            self.sureButton.layer.mask = maskLayer;
            [self.alertView addSubview:self.sureButton];
        }
        
        //计算高度
        CGFloat alertHeight = cancleTitle ? CGRectGetMaxY(self.cancleButton.frame) : CGRectGetMaxY(self.sureButton.frame);
        self.alertView.frame = CGRectMake(0, 0, AlertW, alertHeight);
        self.alertView.layer.position = self.center;
        [self addSubview:self.alertView];
    }
    return self;
}

#pragma mark - <弹出>

- (void)showAlertView
{
    UIWindow * rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self showAnimation];
}

- (void)showAnimation
{
    self.alertView.layer.position = self.center;
    self.alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^
     {
         self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
     }
                     completion:^(BOOL finished)
     {
         
     }];
}

#pragma mark - <Button点击事件>

- (void)buttonClick:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(didSelectButtonWithIndex:)])
    {
        [_delegate didSelectButtonWithIndex:sender.tag];
    }
    [self removeFromSuperview];
}

#pragma mark - <Adapter>

- (UILabel *)getAdaptiveLabelWithFrame:(CGRect)frame andText:(NSString *)text andIsTitle:(BOOL)isTitle
{
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.numberOfLines = 0;
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    
    if (isTitle)
    {
        label.font = [UIFont boldSystemFontOfSize:16.0f];
    }
    else
    {
        label.font = [UIFont systemFontOfSize:14.0];
    }
    
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.lineSpacing = 3.0f;
    [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    [label setAttributedText:string];
    [label sizeToFit];
    
    return label;
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
