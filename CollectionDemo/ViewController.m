//
//  ViewController.m
//  CollectionDemo
//
//  Created by Faker on 15/11/24.
//  Copyright (c) 2015年 Faker. All rights reserved.
//

#import "ViewController.h"
#import "HeadSectionView.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *theCollectView;
@end
@implementation ViewController
{
    NSArray *titleArray; // 头部视图标题
    //布尔数组
    BOOL flag[100];//

}
- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    flowLayout.itemSize = CGSizeMake(375/2 -2, 375/2 -2);
   

    
    
    //设置头部
   [flowLayout setHeaderReferenceSize:CGSizeMake(_theCollectView.frame.size.width, 50)];
    
    
    _theCollectView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _theCollectView.delegate = self;
    _theCollectView.dataSource = self;
    [_theCollectView setBackgroundColor:[UIColor clearColor]];
    //注册Cell，必须要有
    [_theCollectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.view addSubview:_theCollectView];
    _theCollectView.backgroundColor = [UIColor clearColor];

    
    //注册头部视图
    [_theCollectView registerClass:[HeadSectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeadSectionView"];
    titleArray = @[@"你比从前快乐",@"安静",@" 蜗牛",@"晴天"];
    
   
}

#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (flag[section])
    {
        //展开
        if (titleArray.count == 0) {
            return 0;
        }
        //换成网络请求回来的数据源即可
        NSMutableArray *arr = (NSMutableArray *)titleArray;
        return arr.count;
    }
    else
    {
        return 0;
    }
}


//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return titleArray.count;
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        //定制头部视图的内容
        HeadSectionView *headerV = (HeadSectionView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeadSectionView" forIndexPath:indexPath];
        [headerV.btn setTitle:[titleArray objectAtIndex:indexPath.section] forState:UIControlStateNormal];
        headerV.btn.tag =indexPath.section +10;
        [headerV.btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

        
        if (flag[indexPath.section])
        {
            //转90度
            headerV.image1.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        else
        {
            //CGAffineTransformIdentity回到初始位置
            headerV.image1.transform = CGAffineTransformIdentity;
            
        }

        reusableview = headerV;
    }
    return reusableview;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    label.textColor = [UIColor greenColor];
    label.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    [cell.contentView addSubview:label];
    cell.backgroundColor = [UIColor brownColor];
    return cell;
}



#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(375/2 -2, 375/2 -2);
}

//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 0, 0, 0);//分别为上、左、下、右
}

//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



#pragma mark - 点击section响应的方法
- (void)buttonClick:(UIButton *)button
{
    int section = button.tag -10;
    
    flag [section ] =!flag[section];//如果是闭合状态点击后就展开，反之相反。
    
    //结果集 把拿到的数据包起来
    NSIndexSet *name = [NSIndexSet indexSetWithIndex:section];
    [_theCollectView reloadSections:name];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
