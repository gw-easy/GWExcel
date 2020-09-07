//
//  GWExcelTableViewCell.h
//  GWExcel
//
//  Created by gw on 2020/9/2.
//  Copyright © 2020 gw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWExcelModel.h"
NS_ASSUME_NONNULL_BEGIN
@class GWExcelTableViewCell;
@protocol GWExcelTableViewCellDelegate<NSObject>

/// 注册cell
/// @param collectionView collectionView description
/// @param isLeft 是否为左侧
- (void)GWExcelRegisterCollectionView:(UICollectionView *)collectionView isLeft:(BOOL)isLeft;


/// cell
/// @param collectionView collectionView description
/// @param indexPath indexPath description
/// @param isLeft 是否是左侧

- (UICollectionViewCell *)GWExcelCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath isLeft:(BOOL)isLeft;
@optional

/// cell size
/// @param collectionView collectionView description
/// @param collectionViewLayout collectionViewLayout description
/// @param indexPath indexPath description
- (CGSize)GWExcelCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;


/// cell 点击
/// @param indexPath indexPath description
- (void)GWExcelCollectionViewRightViewDidSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface GWExcelTableViewCell : UITableViewCell


@property (strong, nonatomic) GWExcelModel *excelModel;


@property (strong, nonatomic) NSIndexPath *indexPath;

@property (weak, nonatomic) id<GWExcelTableViewCellDelegate> delegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(nonnull NSIndexPath *)indexPath excelModel:(GWExcelModel *)excelModel delegate:(id)delegate;
@end

NS_ASSUME_NONNULL_END
