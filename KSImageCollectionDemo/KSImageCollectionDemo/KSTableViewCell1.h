//
//  KSTableViewCell1.h
//  KSImageCollectionDemo
//
//  Created by kong on 16/9/7.
//  Copyright © 2016年 孔. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KSTableViewCell1;
@protocol KSTableViewCell1Delegate <NSObject>

- (void)ks_tableViewCell:(KSTableViewCell1*)cell willDeleteAtIndexPath:(NSIndexPath*)indexPath;
- (void)ks_tableViewCell:(KSTableViewCell1*)cell didSelectAtIndexPath:(NSIndexPath*)indexPath;
- (void)ks_tableViewCell:(KSTableViewCell1*)cell shouldAddImageAtIndexPath:(NSIndexPath*)indexPath;

@end


@interface KSTableViewCell1 : UITableViewCell

@property (nonatomic, strong) NSArray* imageArray;

@property (nonatomic,weak) id<KSTableViewCell1Delegate> delegate;

@end
