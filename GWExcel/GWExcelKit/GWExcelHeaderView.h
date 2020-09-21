//
//  GWExcelHeaderView.h
//  GWExcel
//
//  Created by gw on 2020/9/2.
//  Copyright © 2020 gw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWExcelModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol GWExcelHeaderViewDelegate <NSObject>
/// header 注册cell
/// @param collectionView collectionView description
/// @param isLeft 是否是左滑动
- (void)GWExcelHeaderRegisterCollectionView:(UICollectionView *)collectionView isLeft:(BOOL)isLeft;

/// header cell
/// @param collectionView collectionView description
/// @param indexPath indexPath description
/// @param isLeft 是否是左滑动
- (UICollectionViewCell *)GWExcelHeaderCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath isLeft:(BOOL)isLeft;

@optional
/// header 点击item
/// @param indexPath indexPath description
/// @param isLeft 是否是左滑动
- (void)GWExcelHeaderViewDidSelectItemAtIndexPath:(NSIndexPath *)indexPath isLeft:(BOOL)isLeft;

/// header cell size
/// @param collectionView collectionView description
/// @param collectionViewLayout collectionViewLayout description
/// @param indexPath indexPath description
- (CGSize)GWExcelHeaderCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface GWExcelHeaderView : UIView

@property (weak, nonatomic) id<GWExcelHeaderViewDelegate> delegate;

- (instancetype)initExcelModel:(GWExcelModel *)excelModel delegate:(id)delegate;

- (void)reloadData;
@end

NS_ASSUME_NONNULL_END
