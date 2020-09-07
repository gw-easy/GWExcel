//
//  GWExcelHeaderRightCell.m
//  GWExcel
//
//  Created by gw on 2020/9/3.
//  Copyright © 2020 gw. All rights reserved.
//

#import "GWExcelHeaderRightCell.h"

@implementation GWExcelHeaderRightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _title = [UILabel new];
        [self.contentView addSubview:_title];
        _title.GW_BoundsEqualView(self.contentView);
        UIView *del = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.bounds.size.height-1, self.contentView.bounds.size.width, 1)];
        del.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:del];
        del.GW_LeftSpace(0)
        .GW_BottomSpace(0)
        .GW_RightSpace(0)
        .GW_Height(1);
    }
    return self;
}

@end
