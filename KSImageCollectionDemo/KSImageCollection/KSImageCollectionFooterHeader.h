//
//  KSImageCollectionFooterHeader.h
//  KSImageCollectionDemo
//
//  Created by kong on 16/9/8.
//  Copyright © 2016年 孔令硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KSImageCollectionFooterHeaderDelegate <NSObject>

- (void)ks_imageCollectionFooterHeaderDidClick;

@end

@interface KSImageCollectionFooterHeader : UICollectionReusableView

@property (nonatomic,weak) id<KSImageCollectionFooterHeaderDelegate> delegate;

@end
