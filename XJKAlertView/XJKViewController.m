//
//  XJKViewController.m
//  XJKAlertView
//
//  Created by 徐靖凯 on 2017/8/16.
//  Copyright © 2017年 徐靖凯. All rights reserved.
//

#import "XJKViewController.h"
#import "XJKAlertView.h"

@interface XJKViewController ()<XJKAlertViewDelegate>

@end

@implementation XJKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = @"XJKAlertView";
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    XJKAlertView * alertView = [[XJKAlertView alloc] initWithTitle:@"提示" Message:@"人都说，爱上一座城，是因为城中住着你爱的人。爱屋及乌自是不言而喻，每个人的生命中都会出现这样一个人，纵使尘满面，鬓如霜，也想要和他相伴到岁末晚景。我深信此画面曾被无数人精心描摹过，因为它是人们心里憧憬的最美的爱相逢。这个浪漫的“版图”，也是温暖与真挚包裹的纯粹感情，所刻画的一幅朴素人生。世间最理想的爱情，当然是两颗同心，一生相濡以沫。擦肩而过，只能说彼此情深缘浅。放手成全，可能给人感觉言过凄美，听着有些颇为冷情，可谁也不能否认这不是因为爱情。爱情是什么？我只能说是一种忘我的感觉，一种怡然心扉的情愫，它体现着爱情的完美纯度。" sureBtn:@"确定" cancleBtn:@"取消"];
    [alertView showAlertView];
    alertView.delegate = self;
}

- (void)didSelectButtonWithIndex:(NSInteger)index
{
    if (index == 1)
    {
        NSLog(@"取消");
    }
    else if (index == 2)
    {
        NSLog(@"确定");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
