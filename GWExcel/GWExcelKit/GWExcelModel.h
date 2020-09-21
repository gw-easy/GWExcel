//
//  GWExcelModel.h
//  GWExcel
//
//  Created by gw on 2020/9/2.
//  Copyright © 2020 gw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
//左右滑动偏移量
static NSString *const GW_EXCEL_NOTIFI_OFFSETX = @"GW_EXCEL_NOTIFI_OFFSETX";

@interface GWExcelModel : NSObject


/** 内部通知的name */
@property (nonatomic, copy, readonly) NSString *NotificationID;

#pragma mark - tableview



/// tableView风格
@property (assign, nonatomic) UITableViewStyle tableStyle;
//tableview右边偏移量
@property (assign, nonatomic) CGFloat tableViewRightOffSet;
//tableview右边偏移量
@property (assign, nonatomic) CGFloat tableViewBottomOffSet;
//section数量
@property (assign, nonatomic) NSInteger numberOfSections;

// 左边表格行数,即纵向行数,必须要赋值
@property (nonatomic, assign) NSInteger leftTableCount;
// 右边表格行数,即横向行数,必须要赋值
@property (nonatomic, assign) NSInteger rightTableCount;
// 表格头部高度, 默认 44.0f
@property (nonatomic, assign) CGFloat sheetHeaderHeight;
// 表格行高, 默认 44.0f
@property (nonatomic, assign) CGFloat sheetRowHeight;
// 表格左侧宽度, 默认为整个表格的 1/3
@property (nonatomic, assign) CGFloat sheetLeftTableWidth;
// 表格右侧宽度, 默认为整个表格的 1/3
@property (nonatomic, assign) CGFloat sheetRightTableWidth;
//GWExcelView 真实宽度 - 配合autoMinRightTableCount使用
@property (assign, nonatomic) CGFloat excelRealyWidth;
// 自动分配表格右侧宽度, 右侧表格会显示该值对应的个数,设置了这个值有会导致 sheetRightTableWidth 失效
@property (nonatomic, assign) NSInteger autoMinRightTableCount;

// bounces past edge of content and back again
@property (assign, nonatomic) BOOL bounces;
// 开启右侧表格横向滚动分页效果, 分页距离为 单个格子宽度
@property (nonatomic, assign) BOOL pagingEnabled;
// 开启右侧表格横向滚动时,左侧表格边界渐变颜色阴影
@property (nonatomic, assign) BOOL showScrollShadow;
// 左侧表格边界渐变颜色, 默认为 [UIColor lightGrayColor]
@property (nonatomic, strong) UIColor * _Nullable scrollShadowColor;
// 左侧表格边界渐变宽度, 默认为 10
@property (nonatomic, assign) CGFloat scrollShadowWidth;
 // 左侧表格边界渐变最大alpha, 默认为 0.4
@property (nonatomic, assign) CGFloat maxScrollShadowColorAlpha;
// 左侧表格边界阴影最小alpha, 默认为 0.1
@property (nonatomic, assign) CGFloat minScrollShadowColorAlpha;


@end

NS_ASSUME_NONNULL_END
