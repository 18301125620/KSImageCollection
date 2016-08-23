//
//  KSImageCollection.h
//  MarryMe
//
//  Created by kong on 16/6/22.
//  Copyright © 2016年 XiaoFanChuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KSImageCollection;
@protocol KSImageCollectionDelegate <NSObject>

- (void)ks_imageCollection:(KSImageCollection*)imageCollection WillDeleteImage:(id)imageObj atIndex:(NSUInteger)index;
- (void)ks_imageCollection:(KSImageCollection*)imageCollection DidSelectImage:(id)imageObj atIndex:(NSUInteger)index;
- (void)ks_imageCollection:(KSImageCollection*)imageCollection ShouldAddImageAtIndex:(NSUInteger)index;

@end

@interface KSImageCollection : UICollectionView

/** 支持UIImage,NSString类型 */
@property (nonatomic,strong,readonly) NSMutableArray* imageArray;

/** 是否不可编辑 删除、添加图片 默认NO */
@property (nonatomic,assign) IBInspectable BOOL Uneditable;

@property (nonatomic,assign) id<KSImageCollectionDelegate> target;

/**
 *  通过modelArray 添加图片
 *
 *  @param array    仅支持一层model
 *  @param property 图片url的属性值
 */
- (void)addImageModelArray:(NSArray*)array property:(NSString*)property;

- (void)addImage:(id)image;

- (void)addImageArray:(NSArray *)array;

- (void)removeAllImages;

@end

/**
 *  慎用通知
 */
extern NSString* const KSImageCollectionWillDeleteImageNotifition;
extern NSString* const KSImageCollectionDidSelectImageNotifition;
extern NSString* const KSImageCollectionShouldAddImageNotifition;

/**
 *  上传图片按钮背景
 */
static NSString* const KSImageCollectAdd = @"KSImageCollectAdd";

