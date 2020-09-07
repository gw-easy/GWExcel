//
//  GWExcelModel.m
//  GWExcel
//
//  Created by gw on 2020/9/2.
//  Copyright © 2020 gw. All rights reserved.
//

#import "GWExcelModel.h"

@interface GWExcelModel()
/** 内部通知的name */
@property (nonatomic, copy, readwrite) NSString *NotificationID;
@end

@implementation GWExcelModel

- (instancetype)init{
    if (self = [super init]) {
        _numberOfSections = 1;
        _sheetHeaderHeight = _sheetRowHeight = 44;
        _sheetLeftTableWidth = _sheetRightTableWidth = [UIScreen mainScreen].bounds.size.width/3.0;
        _autoMinRightTableCount = 2;
        _showScrollShadow = NO;
        _scrollShadowColor = [UIColor lightGrayColor];
        _scrollShadowWidth = 10;
        _maxScrollShadowColorAlpha = 0.4;
        _minScrollShadowColorAlpha = 0.1;
        _pagingEnabled = YES;
    }
    return self;
}

- (NSString *)NotificationID{
    if (!_NotificationID) {
        _NotificationID = [NSString stringWithFormat:@"gw_%f",[[NSDate date] timeIntervalSince1970]];
    }
    return _NotificationID;;
}
@end
