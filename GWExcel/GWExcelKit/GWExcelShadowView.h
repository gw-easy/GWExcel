//
//  GWExcelShadowView.h
//  GWExcel
//
//  Created by gw on 2020/9/4.
//  Copyright © 2020 gw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWExcelModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GWExcelShadowView : UIView

@property (strong, nonatomic) CAGradientLayer *gradientLayer;
/// 初始化
/// @param frame frame description
/// @param excelModel excelModel description
- (instancetype)initWithFrame:(CGRect)frame excelModel:(GWExcelModel *)excelModel;
@end

NS_ASSUME_NONNULL_END
