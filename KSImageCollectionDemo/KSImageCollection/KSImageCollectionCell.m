//
//  KSImageCollectionCell.m
//  KSImageCollectionDemo
//
//  Created by kong on 16/9/8.
//  Copyright © 2016年 孔令硕. All rights reserved.
//

#import "KSImageCollectionCell.h"
#import "UIImageView+WebCache.h"


@implementation KSImageCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectInset(self.bounds, 5, 5);
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_imageView];
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 100;
        btn.frame = CGRectMake(self.bounds.size.width - 15, 0, 15, 15);
        [btn setBackgroundImage:[UIImage imageNamed:@"KSImageCollection.bundle/KSImageCollectRemove"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(removeImage:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
    }
    return self;
}

- (void)setImageObject:(id)imageObject{
    if (_imageObject != imageObject) {
        _imageObject = imageObject;
        
        if ([_imageObject isKindOfClass:[NSString class]]) {
            
            [_imageView sd_setImageWithURL:[NSURL URLWithString:_imageObject] placeholderImage:[UIImage imageNamed:@"icon_default"]];
            
        }else if ([imageObject isKindOfClass:[UIImage class]]){
            
            _imageView.image = _imageObject;
            
        }else{
            _imageView.image = nil;
        }
    }
}

- (void)setEditing:(BOOL)editing{
    _editing = editing;
    [self.contentView viewWithTag:100].hidden = !editing;
}


- (void)removeImage:(UIButton*)sender{
    
    if (_delegate && [_delegate respondsToSelector:@selector(ks_imageCollectionCell:didClickRemoveObject:atIndex:)]) {
        [_delegate ks_imageCollectionCell:self didClickRemoveObject:_imageObject atIndex:self.indexPath.row];
    }
}

- (NSIndexPath*)indexPath{
    UIView* next = self.superview;
    while (![next isKindOfClass:[UICollectionView class]]) {
        next = next.superview;
    }
    UICollectionView* collectionView = (UICollectionView*)next;
    return [collectionView indexPathForCell:self];
}

@end
