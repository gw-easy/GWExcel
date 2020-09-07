//
//  ViewController.m
//  GWExcel
//
//  Created by gw on 2020/9/2.
//  Copyright © 2020 gw. All rights reserved.
//

#import "ViewController.h"
#import "GWExcelView.h"
#import "GWExcelHeaderLeftCell.h"
#import "GWExcelHeaderRightCell.h"
#import "GWExcelConcentLeftCell.h"
#import "GWExcelConcentRightCell.h"
@interface ViewController ()<GWExcelViewDelegate>
@property (strong, nonatomic) GWExcelModel *exModel;
@property (nonatomic, strong) NSMutableArray *fixedColumnList;
@property (nonatomic, strong) NSMutableArray  *fixedList;
@property (strong, nonatomic) GWExcelView *exView;

@end

@implementation ViewController
- (IBAction)reloadBtn:(id)sender {
    _exModel.sheetRightTableWidth = 150;
    [_exView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _fixedColumnList = [NSMutableArray new];
    [_fixedColumnList addObject:@"固定1"];
    
//    NSArray *arr1 = @[@"语文",@"数学",@"物理",@"化学",@"生物",@"英语",@"政治",@"语文",@"数学",@"物理",@"化学",@"生物",@"英语",@"政治"];
//    [_fixedColumnList addObjectsFromArray:arr1];

    for (int j = 0; j < 100; j ++) {
        [_fixedColumnList addObject:[NSString stringWithFormat:@"%d--",j]];
    }
    
    _fixedList = @[].mutableCopy;
    for (int j = 0; j < 100; j ++) {
        NSMutableArray *cloumnList = @[].mutableCopy;
        for (int i = 0; i < _fixedColumnList.count; i ++) {
            NSString *ld = [NSString stringWithFormat:@"%d行%d列",j,i];
            [cloumnList addObject:ld];
        }
        [_fixedList addObject:cloumnList];
    }
    
    
    _exModel = [GWExcelModel new];
    _exModel.sheetHeaderHeight = 50;
    _exModel.sheetLeftTableWidth = 100;
    _exModel.sheetRowHeight = 100;
    _exModel.sheetRightTableWidth = 80;
    _exModel.leftTableCount = _fixedList.count;
    _exModel.rightTableCount = _fixedColumnList.count-1;
    _exModel.excelRealyWidth = self.view.bounds.size.width-20;
    _exModel.showScrollShadow = YES;
    _exView = [[GWExcelView alloc] initWithFrame:CGRectZero model:_exModel delegate:self];
    [self.view addSubview:_exView];
    self.view.backgroundColor = [UIColor redColor];
    _exView.GW_LeftSpace(10)
    .GW_RightSpace(10)
    .GW_TopSpace(100)
    .GW_BottomSpace(88);
    [_exView reloadData];
    [self.view layoutIfNeeded];
    CAShapeLayer *mask=[CAShapeLayer layer];
    
     UIBezierPath * path= [UIBezierPath bezierPathWithRoundedRect:_exView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(20,20)];
     mask.path=path.CGPath;
     mask.frame=_exView.bounds;
     _exView.layer.mask = mask;
}

- (NSInteger)GWExcelTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _fixedList.count;
}

- (nonnull UICollectionViewCell *)GWExcelCollectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath isLeft:(BOOL)isLeft {
    if (isLeft) {
        GWExcelConcentLeftCell *leftCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GWExcelConcentLeftCell" forIndexPath:indexPath];
        leftCell.title.text = _fixedList[indexPath.section][0];
//        leftCell.backgroundColor = [UIColor blueColor];
        return leftCell;
    }
    GWExcelConcentRightCell *rightCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GWExcelConcentRightCell" forIndexPath:indexPath];
    rightCell.title.text = _fixedList[indexPath.section][indexPath.row+1];
//    rightCell.backgroundColor = [UIColor greenColor];
    return rightCell;
}

- (void)GWExcelRegisterCollectionView:(nonnull UICollectionView *)collectionView isLeft:(BOOL)isLeft {
    [collectionView registerClass:NSClassFromString(isLeft?@"GWExcelConcentLeftCell":@"GWExcelConcentRightCell") forCellWithReuseIdentifier:isLeft?@"GWExcelConcentLeftCell":@"GWExcelConcentRightCell"];
}

- (nonnull UICollectionViewCell *)GWExcelHeaderCollectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath isLeft:(BOOL)isLeft {
    if (isLeft) {
        GWExcelHeaderLeftCell *leftCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GWExcelHeaderLeftCell" forIndexPath:indexPath];
        leftCell.title.text = _fixedColumnList[0];
        leftCell.backgroundColor = [UIColor whiteColor];
        return leftCell;
    }
    GWExcelHeaderRightCell *rightCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GWExcelHeaderRightCell" forIndexPath:indexPath];
    rightCell.title.text = _fixedColumnList[indexPath.row+1];
    rightCell.backgroundColor = [UIColor whiteColor];
    return rightCell;
}

- (void)GWExcelHeaderRegisterCollectionView:(nonnull UICollectionView *)collectionView isLeft:(BOOL)isLeft {
    if (!isLeft) {
         [collectionView registerClass:NSClassFromString(@"GWExcelHeaderRightCell") forCellWithReuseIdentifier:@"GWExcelHeaderRightCell"];
    }else{
        [collectionView registerNib:[UINib nibWithNibName:@"GWExcelHeaderLeftCell" bundle:nil] forCellWithReuseIdentifier:@"GWExcelHeaderLeftCell"];
    }
//    [collectionView registerClass:NSClassFromString(isLeft?@"GWExcelHeaderLeftCell":@"GWExcelHeaderRightCell") forCellWithReuseIdentifier:isLeft?@"GWExcelHeaderLeftCell":@"GWExcelHeaderRightCell"];
//    [collectionView registerNib:[UINib nibWithNibName:isLeft?@"GWExcelHeaderLeftCell":@"GWExcelHeaderRightCell" bundle:nil] forCellWithReuseIdentifier:isLeft?@"GWExcelHeaderLeftCell":@"GWExcelHeaderRightCell"];
}

- (void)GWExcelTableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == _fixedList.count-1) {
        CAShapeLayer *mask=[CAShapeLayer layer];
       
        UIBezierPath * path= [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(20,20)];
        mask.path=path.CGPath;
        mask.frame=cell.bounds;
        cell.layer.mask = mask;
    }else{
        UIBezierPath * path= [UIBezierPath bezierPathWithRect:cell.bounds];
        CAShapeLayer *mask=[CAShapeLayer layer];
        mask.path=path.CGPath;
        mask.frame=cell.bounds;
        cell.layer.mask = mask;
    }
}
@end
