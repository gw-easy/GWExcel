//
//  GWExcelView.h
//  GWExcel
//
//  Created by gw on 2020/9/2.
//  Copyright © 2020 gw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWExcelModel.h"
#import "GWExcelTabelView.h"
#import "GWExcelHeaderView.h"
#import "GWExcelTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@protocol GWExcelViewDelegate <GWExcelTableViewCellDelegate,GWExcelHeaderViewDelegate>

@optional

/// 每列有多少行
/// @param tableView tableView description
/// @param section section description
- (NSInteger)GWExcelTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;


/// cell将要显示
/// @param tableView tableView description
/// @param cell cell description
/// @param indexPath indexPath description
- (void)GWExcelTableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;


/// section的header
/// @param tableView tableView description
/// @param section section description
- (UIView *)GWExcelTableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;


/// section的header的高
/// @param tableView tableView description
/// @param section section description
- (CGFloat)GWExcelTableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;


/// tableview滚动事件
/// @param scrollView scrollView description
- (void)GWExcelTableViewScrollViewDidScroll:(UIScrollView *)scrollView;
@end

@interface GWExcelView : UIView
//表格初始化数据
@property (strong, nonatomic) GWExcelModel *excelModel;

@property (strong, nonatomic) UITableView *excelTableView;

@property (strong, nonatomic) GWExcelHeaderView *excelHeaderView;

@property (weak, nonatomic) id<GWExcelViewDelegate> delegate;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

/// 初始化
/// @param frame frame
/// @param model model description
- (instancetype)initWithFrame:(CGRect)frame model:(GWExcelModel *)model delegate:(id)delegate;

//刷新
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
