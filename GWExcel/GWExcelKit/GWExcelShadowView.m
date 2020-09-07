//
//  GWExcelShadowView.m
//  GWExcel
//
//  Created by gw on 2020/9/4.
//  Copyright © 2020 gw. All rights reserved.
//

#import "GWExcelShadowView.h"

@implementation GWExcelShadowView

- (instancetype)initWithFrame:(CGRect)frame excelModel:(GWExcelModel *)excelModel{
    if (self = [super initWithFrame:frame]) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.bounds;
        _gradientLayer.colors = @[(__bridge id)[self getNewColorWith:excelModel.scrollShadowColor alpha:excelModel.maxScrollShadowColorAlpha].CGColor,(__bridge id)[self getNewColorWith:excelModel.scrollShadowColor alpha:excelModel.minScrollShadowColorAlpha].CGColor];
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(1, 0);
        _gradientLayer.locations = @[@0,@1];
        [self.layer addSublayer:_gradientLayer];
    }
    return self;
}

- (UIColor *)getNewColorWith:(UIColor *)color alpha:(CGFloat)alpha {
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat oldAlpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&oldAlpha];
    UIColor *newColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return newColor;
}

@end
