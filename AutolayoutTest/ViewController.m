//
//  ViewController.m
//  AutolayoutTest
//
//  Created by 孙亚锋 on 2017/4/24.
//  Copyright © 2017年 yafeng. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
@interface ViewController ()
@property(nonatomic,strong)UIView *redView;
@property(nonatomic,strong)UIView *blueView;
@property(nonatomic,strong)UIView *orangeView;

@property(nonatomic,strong)UIView *redViewMas;
@property(nonatomic,strong)UIView *blueViewMas;
@property(nonatomic,strong)UIView *orangeViewMas;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  NSLayoutConstraint 约束
    [self setupSubviews];
    
    // Masonry 约束
    [self setupSubviewsForMasonry];
    
}
-(void)setupSubviewsForMasonry{
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:redView];
    self.redViewMas = redView;
    UIView *blueView = [[UIView alloc]init];
    blueView.backgroundColor = [UIColor blueColor];
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:blueView];
    self.blueViewMas = blueView;
    UIView *orangeView = [[UIView alloc]init];
    orangeView.backgroundColor = [UIColor orangeColor];
    orangeView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:orangeView];
    self.orangeViewMas = orangeView;
    
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(150);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
    }];
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(redView.mas_right).offset(30);
        make.top.mas_equalTo(150);
        make.width.and.height.mas_equalTo(redView);
    }];
    [orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(blueView.mas_right).offset(30);
        make.top.mas_equalTo(150);
        make.width.and.height.mas_equalTo(redView);
        //优先级
        make.left.mas_equalTo(redView.mas_right).offset(30).priority(250);
    }];
}
#pragma mark - NSLayoutConstraint 约束
-(void)setupSubviews{
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:redView];
    self.redView = redView;
    //距离左边的约束 相对于self.view 的左边缘间距 30
    NSLayoutConstraint *leftLC = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:30.0f];
    [self.view addConstraint:leftLC];
    //距离上面的约束 相对于self.view 的顶部边缘间距 30
    NSLayoutConstraint *topLc = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:30.0f];
    [self.view addConstraint:topLc];
    // 设置自身宽
    NSLayoutConstraint *redWidthLc = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0f constant:80.0f];
    [redView addConstraint:redWidthLc];
    // 设置自身高
    NSLayoutConstraint *redHeightLc = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0f constant:80.0f];
    [redView addConstraint:redHeightLc];

    
    //需求  再加个 蓝色的view
    UIView *blueView = [[UIView alloc]init];
    blueView.backgroundColor = [UIColor blueColor];
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:blueView];
    self.blueView = blueView;
    NSLayoutConstraint *blueLeftLc =[NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:redView attribute:NSLayoutAttributeRight multiplier:1.0 constant:30.0f];
    [self.view addConstraint:blueLeftLc];
    
    NSLayoutConstraint *buleTopLc =[NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:redView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    [self.view addConstraint:buleTopLc];
    
    //剩下两个约束差不多，我就一并描述了，它们都以redView为参照，与其等宽等高
    NSLayoutConstraint *blueW = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:redView attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f];
    [self.view addConstraint:blueW];
    
    NSLayoutConstraint *blueH = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:redView attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0.0f];
    [self.view addConstraint:blueH];
    
    // 最后再加一个黄色的View
    UIView * orangeView =[[UIView alloc]init];
    orangeView.backgroundColor = [UIColor orangeColor];
    orangeView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:orangeView];
    self.orangeView = orangeView;
    //开始创建约束，第一个约束是什么呢？一看就知道是左间距约束啦
    NSLayoutConstraint *orangeLeft = [NSLayoutConstraint constraintWithItem:orangeView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeRight multiplier:1.0f constant:30];
    //与其他控件发生约束，所以约束添加到父控件上
    [self.view addConstraint:orangeLeft];
    //添加顶部约束
    NSLayoutConstraint *orangetop = [NSLayoutConstraint constraintWithItem:orangeView attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:30];
    //与其他控件发生约束，所以约束添加到父控件上
    [self.view addConstraint:orangetop];
    //这里我直接设置宽高约束了，就省事不加参照控件了
    NSLayoutConstraint *orangeW = [NSLayoutConstraint constraintWithItem:orangeView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0f constant:80.0f];
    [orangeView addConstraint:orangeW];
    
    NSLayoutConstraint *orangeH = [NSLayoutConstraint constraintWithItem:orangeView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0f constant:80.0f];
    [orangeView addConstraint:orangeH];
    //对黄色View添加约束，约束黄色view与红色View的间距为30
    NSLayoutConstraint *orangeAnotherLeft = [NSLayoutConstraint constraintWithItem:orangeView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:redView attribute:NSLayoutAttributeRight multiplier:1.0f constant:30];
    UILayoutPriority priority = 250;//设置优先级
    orangeAnotherLeft.priority = priority;
    [self.view addConstraint:orangeAnotherLeft];
    
    /*
     我给orangeAnotherLeft这个约束添加了优先级，优先级的范围是0~1000，数字越大，优先级越高，在不设置的情况下默认为1000
     这说明了，我最后添加的这个约束的优先级是低的，这个约束只有在它的冲突约束被抹掉后，它才能实现
     也就是说，我把蓝色view移除后，黄色View相对于蓝色View左间距20这个约束就不成立了，那么黄色view会自动的变为与红色View间距20
     */
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.blueView removeFromSuperview];
    [UIView animateWithDuration:1.0 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.blueViewMas removeFromSuperview];
        [UIView animateWithDuration:1.0 animations:^{
            [self.view layoutIfNeeded];
        }];
    });
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
