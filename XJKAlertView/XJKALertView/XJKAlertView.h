//
//  XJKAlertView.h
//  XJKAlertView
//
//  Created by 徐靖凯 on 2017/8/16.
//  Copyright © 2017年 徐靖凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XJKAlertViewDelegate;

@interface XJKAlertView : UIView

@property (nonatomic, weak) id <XJKAlertViewDelegate> delegate;

/*
 * 初始化方法
 * title ：标题
 * message ：内容
 * sureBtn ：确认按钮上显示的标题
 * cancleBtn ：取消按钮上显示的标题
 */
- (instancetype) initWithTitle:(NSString *)title
                       Message:(NSString *)message
                       sureBtn:(NSString *)sureTitle
                     cancleBtn:(NSString *)cancleTitle;

- (void)showAlertView;

@end

@protocol XJKAlertViewDelegate <NSObject>
/*
 * 点击Button的回调
 * cancleButton index == 1
 * sureButton index == 2
 */
- (void)didSelectButtonWithIndex:(NSInteger)index;

@end
