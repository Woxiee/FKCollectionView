//
//  HeadSectionView.m
//  CollectionDemo
//
//  Created by Faker on 15/11/24.
//  Copyright (c) 2015年 Faker. All rights reserved.
//

#import "HeadSectionView.h"

@implementation HeadSectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.backgroundColor = [UIColor cyanColor];
        [self addSubview:_titleLab];
        
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = _titleLab.frame;
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_btn];
        
        _image1 = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 25, 12, 13, 20)];
        _image1.image = [UIImage imageNamed:@"columarightarrow"];
        [self addSubview:_image1];
    }
    return self;
}



@end
