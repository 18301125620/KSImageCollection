//
//  KSTableViewCell1.m
//  KSImageCollectionDemo
//
//  Created by kong on 16/9/7.
//  Copyright © 2016年 孔. All rights reserved.
//

#import "KSTableViewCell1.h"
#import "KSImageCollection.h"

@interface KSTableViewCell1 ()<KSImageCollectionDelegate>

@property (nonatomic, strong) KSImageCollection* imageCollection;

@end

@implementation KSTableViewCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.imageCollection = [[KSImageCollection alloc] init];
        self.imageCollection.target = self;
        self.imageCollection.maxCount = 100;
        self.imageCollection.editing = YES;
        self.imageCollection.orientation = KSImageCollectionOrientationBack;
        [self.contentView addSubview:self.imageCollection];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _imageCollection.frame = self.contentView.bounds;
}

- (void)setImageArray:(NSArray *)imageArray{
    _imageArray = imageArray;
    [_imageCollection setImageArray:imageArray];
    
}

#pragma mark-
#pragma mark- KSImageCollectionDelegate
- (void)ks_imageCollection:(KSImageCollection *)imageCollection shouldAddImageAtIndex:(NSUInteger)index{
    //添加图片
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:index inSection:self.indexPath.row];
    
    if (_delegate && [_delegate respondsToSelector:@selector(ks_tableViewCell:shouldAddImageAtIndexPath:)]) {
        [_delegate ks_tableViewCell:self shouldAddImageAtIndexPath:indexPath];
    }
}
- (void)ks_imageCollection:(KSImageCollection *)imageCollection didSelectImage:(id)imageObj atIndex:(NSUInteger)index{
    //点击图片
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:index inSection:self.indexPath.row];

    if (_delegate && [_delegate respondsToSelector:@selector(ks_tableViewCell:didSelectAtIndexPath:)]) {
        [_delegate ks_tableViewCell:self didSelectAtIndexPath:indexPath];
    }
}
- (void)ks_imageCollection:(KSImageCollection *)imageCollection willDeleteImage:(id)imageObj atIndex:(NSUInteger)index{
    //删除图片
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:index inSection:self.indexPath.row];

    if (_delegate && [_delegate respondsToSelector:@selector(ks_tableViewCell:willDeleteAtIndexPath:)]) {
        [_delegate ks_tableViewCell:self willDeleteAtIndexPath:indexPath];
    }
}

- (NSIndexPath*)indexPath{
    UIView* superView = self.superview;
    Class class = [UITableView class];
    while (![superView isKindOfClass:class]) {
        superView = superView.superview;
    }

    return [((UITableView*)superView) indexPathForCell:self];
}
@end
