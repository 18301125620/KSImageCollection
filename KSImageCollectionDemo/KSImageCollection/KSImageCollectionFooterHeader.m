//
//  KSImageCollectionFooterHeader.m
//  KSImageCollectionDemo
//
//  Created by kong on 16/9/8.
//  Copyright © 2016年 孔令硕. All rights reserved.
//

#import "KSImageCollectionFooterHeader.h"

@implementation KSImageCollectionFooterHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectInset(self.bounds, 5, 5);
        [btn setBackgroundImage:[UIImage imageNamed:@"KSImageCollection.bundle/KSImageCollectAdd"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}

- (void)selectImage:(UIButton*)sender{
    
    if (_delegate && [_delegate respondsToSelector:@selector(ks_imageCollectionFooterHeaderDidClick)]) {
        [_delegate ks_imageCollectionFooterHeaderDidClick];
    }
}

@end