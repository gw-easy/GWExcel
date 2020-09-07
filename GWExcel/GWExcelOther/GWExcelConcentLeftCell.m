//
//  GWExcelConcentLeftCell.m
//  GWExcel
//
//  Created by gw on 2020/9/3.
//  Copyright © 2020 gw. All rights reserved.
//

#import "GWExcelConcentLeftCell.h"

@implementation GWExcelConcentLeftCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _title = [UILabel new];
        [self.contentView addSubview:_title];
        _title.GW_BoundsEqualView(self.contentView);
        UIView *aaV = [[UIView alloc] init];
        [self.contentView addSubview:aaV];
        aaV.backgroundColor = [UIColor grayColor];
        aaV.GW_LeftSpace(0)
        .GW_BottomSpace(0)
        .GW_RightSpace(0)
        .GW_Height(1);
        
        UIView *rV = [[UIView alloc] init];
        [self.contentView addSubview:rV];
        rV.backgroundColor = [UIColor grayColor];
        rV.GW_Width(1)
        .GW_TopSpace(0)
        .GW_BottomSpace(0)
        .GW_RightSpace(0);
    }
    return self;
}
@end
