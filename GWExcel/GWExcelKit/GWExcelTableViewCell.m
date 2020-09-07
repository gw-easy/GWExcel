//
//  GWExcelTableViewCell.m
//  GWExcel
//
//  Created by gw on 2020/9/2.
//  Copyright © 2020 gw. All rights reserved.
//

#import "GWExcelTableViewCell.h"

@interface GWExcelTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (assign, nonatomic) BOOL isAllowedNotification;
@property (assign, nonatomic) CGFloat lastOffX;

@property (strong, nonatomic) UICollectionView *excelLeftCollectionV;

@property (strong, nonatomic) UICollectionView *excelRightCollectionV;

@end

@implementation GWExcelTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(nonnull NSIndexPath *)indexPath excelModel:(GWExcelModel *)excelModel delegate:(id)delegate{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _indexPath = indexPath;
        _delegate = delegate;
        _excelModel = excelModel;
        [self setUI:indexPath];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollMove:) name:excelModel.NotificationID object:nil];
    }
    return self;
}

- (void)setUI:(NSIndexPath *)indexPath{
    
    UICollectionViewFlowLayout *layoutL = [UICollectionViewFlowLayout new];
    [layoutL setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layoutL.minimumInteritemSpacing = 0;
    layoutL.minimumLineSpacing = 0;
    _excelLeftCollectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, _excelModel.sheetLeftTableWidth, _excelModel.sheetRowHeight) collectionViewLayout:layoutL];
    _excelLeftCollectionV.delegate = self;
    _excelLeftCollectionV.dataSource = self;
    _excelLeftCollectionV.showsHorizontalScrollIndicator = NO;
    _excelLeftCollectionV.bounces = NO;
    _excelLeftCollectionV.backgroundColor = self.contentView.backgroundColor;
    [self.contentView addSubview:_excelLeftCollectionV];
    
    UICollectionViewFlowLayout *layoutR = [UICollectionViewFlowLayout new];
    [layoutR setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layoutR.minimumInteritemSpacing = 0;
    layoutR.minimumLineSpacing = 0;
    _excelRightCollectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(_excelModel.sheetLeftTableWidth, 0, self.bounds.size.width-_excelModel.sheetLeftTableWidth, _excelModel.sheetRowHeight) collectionViewLayout:layoutR];
    _excelRightCollectionV.delegate = self;
    _excelRightCollectionV.dataSource = self;
    _excelRightCollectionV.showsHorizontalScrollIndicator = NO;
    _excelRightCollectionV.bounces = NO;
    _excelRightCollectionV.backgroundColor = self.contentView.backgroundColor;

    [self.contentView addSubview:_excelRightCollectionV];
    
    if (_delegate && [_delegate respondsToSelector:@selector(GWExcelRegisterCollectionView:isLeft:)]) {
        [_delegate GWExcelRegisterCollectionView:_excelLeftCollectionV isLeft:YES];
        [_delegate GWExcelRegisterCollectionView:_excelRightCollectionV isLeft:NO];
    }
    
    _excelLeftCollectionV.GW_LeftSpace(0)
    .GW_TopSpace(0)
    .GW_BottomSpace(0)
    .GW_Width(_excelModel.sheetLeftTableWidth);
    
    _excelRightCollectionV.GW_LeftSpaceToView(0, _excelLeftCollectionV)
    .GW_TopSpace(0)
    .GW_BottomSpace(0)
    .GW_RightSpace(0);
    
    [_excelLeftCollectionV reloadData];
    [_excelRightCollectionV reloadData];
}

- (void)setExcelModel:(GWExcelModel *)excelModel{
    _excelModel = excelModel;
    if (_excelRightCollectionV) {
        [_excelLeftCollectionV reloadData];
        [_excelRightCollectionV reloadData];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollNotification:(UIScrollView *)scrollView{
    if (!_isAllowedNotification) {//是自身才发通知去tableView以及其他的cell
        // 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:_excelModel.NotificationID object:self userInfo:@{GW_EXCEL_NOTIFI_OFFSETX:@(scrollView.contentOffset.x)}];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _isAllowedNotification = NO;//
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
   [self scrollNotification:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _isAllowedNotification = NO;
    [self scrollNotification:scrollView];
}

- (CGPoint)nearestTargetOffsetForOffset:(CGPoint)offset {
    CGFloat pageSize =_excelModel.sheetRightTableWidth*2;
    NSInteger page = roundf(offset.x / pageSize);
    CGFloat targetX = pageSize * page;
    return CGPointMake(targetX, offset.y);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self scrollNotification:scrollView];
    _isAllowedNotification = NO;
}

- (void)scrollMove:(NSNotification*)notification{
    NSDictionary *noticeInfo = notification.userInfo;
    NSObject *obj = notification.object;
    float x = [noticeInfo[GW_EXCEL_NOTIFI_OFFSETX] floatValue];
    
    if (obj != self) {
        _isAllowedNotification = YES;
        if (_lastOffX != x) {
            [_excelRightCollectionV setContentOffset:CGPointMake(x, 0) animated:NO];
        }
        _lastOffX = x;
    }else{
        _isAllowedNotification = NO;
    }
    obj = nil;
}

#pragma mark - UIScrollViewDelegate 分页滚动





- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == _excelLeftCollectionV) {
        return 1;
    }
    return _excelModel.rightTableCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(GWExcelCollectionView:cellForItemAtIndexPath:isLeft:)]) {
        return [_delegate GWExcelCollectionView:collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:_indexPath.row] isLeft:(collectionView == _excelLeftCollectionV)];
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(GWExcelCollectionViewRightViewDidSelectItemAtIndexPath:)]) {
        [_delegate GWExcelCollectionViewRightViewDidSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

//minimumLineSpacing指的是同一个section 内部 item 和滚动方向垂直方向的最小间距； 如果实际间距比较大则不生效
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.f;
}

//minimumInteritemSpacing指的是同一个section 内部 item 的滚动方向的最小间距； 如果实际间距比较大则不生效
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.f;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(GWExcelCollectionView:layout:sizeForItemAtIndexPath:)]) {
        return [_delegate GWExcelCollectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:_indexPath.section]];
    }
    return CGSizeMake((collectionView==_excelLeftCollectionV)?_excelModel.sheetLeftTableWidth:_excelModel.sheetRightTableWidth, _excelModel.sheetRowHeight);
}

//设置section的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

//footer的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}

//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeZero;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//多种手势处理
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}
@end
