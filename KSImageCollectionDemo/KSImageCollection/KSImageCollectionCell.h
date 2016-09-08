//
//  KSImageCollectionCell.h
//  KSImageCollectionDemo
//
//  Created by kong on 16/9/8.
//  Copyright © 2016年 孔令硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KSImageCollectionCell;
@protocol KSImageCollectionCellDelegate <NSObject>

- (void)ks_imageCollectionCell:(KSImageCollectionCell*)cell didClickRemoveObject:(id)object atIndex:(NSUInteger)index;

@end
@interface KSImageCollectionCell : UICollectionViewCell

@property (nonatomic,strong) id imageObject;
@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic,assign) BOOL editing;

@property (nonatomic,weak) id<KSImageCollectionCellDelegate> delegate;

@end
