//
//  GWExcelView.m
//  GWExcel
//
//  Created by gw on 2020/9/2.
//  Copyright © 2020 gw. All rights reserved.
//

#import "GWExcelView.h"
#import "GWExcelShadowView.h"
@interface GWExcelView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) CGFloat cellLastX;

@property (strong, nonatomic) GWExcelShadowView *shadowV;

@end

@implementation GWExcelView

- (void)reloadData{
    [self refrashRightWidth];
    [self.excelHeaderView reloadData];
    [self.excelTableView reloadData];
}

- (void)refrashRightWidth{
    CGFloat sWidth = _excelModel.excelRealyWidth > 0?_excelModel.excelRealyWidth:self.bounds.size.width;

    if (_excelModel.autoMinRightTableCount > 0 && sWidth>0) {
        _excelModel.sheetRightTableWidth = (sWidth - _excelModel.sheetLeftTableWidth) / _excelModel.autoMinRightTableCount;
        if ((sWidth - _excelModel.sheetLeftTableWidth) > _excelModel.rightTableCount * _excelModel.sheetRightTableWidth) {
            _excelModel.sheetRightTableWidth = (sWidth - _excelModel.sheetLeftTableWidth) / _excelModel.rightTableCount;
        }
    }
}

- (instancetype)initWithFrame:(CGRect)frame model:(GWExcelModel *)model delegate:(id)delegate{
    if (self = [super initWithFrame:frame]) {
        _excelModel = model;
        _delegate = delegate;
        [self refrashRightWidth];
        [self setUI];
    }
    return self;
}

- (void)setUI{
    [self excelHeaderView];
    [self excelTableView];
    _excelHeaderView.GW_LeftSpace(0)
    .GW_RightSpaceEqualViewOffset(self, _excelModel.tableViewRightOffSet)
    .GW_TopSpace(0)
    .GW_Height(_excelModel.sheetHeaderHeight);
    
    _excelTableView.GW_LeftSpace(0)
    .GW_RightSpaceEqualViewOffset(self, _excelModel.tableViewRightOffSet)
    .GW_TopSpaceToView(0, _excelHeaderView)
    .GW_BottomSpaceEqualViewOffset(self, _excelModel.tableViewBottomOffSet);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollMove:) name:_excelModel.NotificationID object:nil];
}

#pragma mark-- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.excelTableView]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:_excelModel.NotificationID object:self userInfo:@{GW_EXCEL_NOTIFI_OFFSETX:@(self.cellLastX)}];
        if (_delegate && [_delegate respondsToSelector:@selector(GWExcelTableViewScrollViewDidScroll:)]) {
            [_delegate GWExcelTableViewScrollViewDidScroll:scrollView];
        }

    }
}

-(void)scrollMove:(NSNotification*)notification{
    NSDictionary *noticeInfo = notification.userInfo;
    float x = [noticeInfo[GW_EXCEL_NOTIFI_OFFSETX] floatValue];
    if (self.cellLastX != x) {//避免重复设置偏移量
        self.cellLastX = x;
        if (_excelModel.showScrollShadow) {
            [self shadowV].hidden = NO;
        }
    }else{
        if (_excelModel.showScrollShadow) {
            [self shadowV].hidden = YES;
        }
    }
    noticeInfo = nil;
}



#pragma mark - tableview-datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _excelModel.numberOfSections;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_delegate && [_delegate respondsToSelector:@selector(GWExcelTableView:numberOfRowsInSection:)]) {
         return [_delegate GWExcelTableView:tableView numberOfRowsInSection:section];
    }
    return _excelModel.leftTableCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _excelModel.sheetRowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GWExcelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GWExcelTableViewCell" ];
    if (!cell) {
        cell = [[GWExcelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GWExcelTableViewCell" indexPath:indexPath excelModel:_excelModel delegate:_delegate];
    }
    
    cell.indexPath = indexPath;
    cell.excelModel = _excelModel;
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(GWExcelTableView:willDisplayCell:forRowAtIndexPath:)]) {
        [_delegate GWExcelTableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_delegate && [_delegate respondsToSelector:@selector(GWExcelTableView:viewForHeaderInSection:)]) {
        return [_delegate GWExcelTableView:tableView viewForHeaderInSection:section];
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_delegate && [_delegate respondsToSelector:@selector(GWExcelTableView:heightForHeaderInSection:)]) {
        return [_delegate GWExcelTableView:tableView heightForHeaderInSection:section];
    }
    return 0.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (_delegate && [_delegate respondsToSelector:@selector(GWExcelTableView:viewForFooterInSection:)]) {
        return [_delegate GWExcelTableView:tableView viewForFooterInSection:section];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (_delegate && [_delegate respondsToSelector:@selector(GWExcelTableView:heightForFooterInSection:)]) {
        return [_delegate GWExcelTableView:tableView heightForFooterInSection:section];
    }
    return 0.0001f;
}

- (UITableView *)excelTableView{
    if (!_excelTableView) {
        _excelTableView = [[UITableView alloc] initWithFrame:CGRectZero style:_excelModel.tableStyle];
            _excelTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _excelTableView.dataSource = self;
        _excelTableView.delegate = self;
        _excelTableView.backgroundColor = [UIColor clearColor];
        _excelTableView.bounces = _excelModel.bounces;
        if (@available(iOS 11.0, *)) {
            _excelTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _excelTableView.estimatedRowHeight =0;
            _excelTableView.estimatedSectionHeaderHeight =0;
            _excelTableView.estimatedSectionFooterHeight =0;
        }
        [self addSubview:_excelTableView];
    }
    return _excelTableView;;
}

- (GWExcelHeaderView *)excelHeaderView{
    if (!_excelHeaderView) {
        _excelHeaderView = [[GWExcelHeaderView alloc] initExcelModel:_excelModel delegate:_delegate];
        _excelHeaderView.backgroundColor = [UIColor clearColor];
        [self addSubview:_excelHeaderView];
    }
    return _excelHeaderView;;
}

- (GWExcelShadowView *)shadowV{
    if (!_shadowV) {
        _shadowV = [[GWExcelShadowView alloc] initWithFrame:CGRectMake(_excelModel.sheetLeftTableWidth, 0, _excelModel.scrollShadowWidth, self.bounds.size.height) excelModel:_excelModel];
        [self addSubview:_shadowV];
    }
    return _shadowV;;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
