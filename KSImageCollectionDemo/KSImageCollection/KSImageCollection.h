//
//  KSImageCollection.h
//  MarryMe
//
//  Created by kong on 16/6/22.
//  Copyright © 2016年 孔令硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KSImageCollection;
@protocol KSImageCollectionDelegate <NSObject>

@optional
- (void)ks_imageCollection:(KSImageCollection*)imageCollection willDeleteImage:(id)imageObj atIndex:(NSUInteger)index;
- (void)ks_imageCollection:(KSImageCollection*)imageCollection didSelectImage:(id)imageObj atIndex:(NSUInteger)index;
- (void)ks_imageCollection:(KSImageCollection*)imageCollection shouldAddImageAtIndex:(NSUInteger)index;

@end

@interface KSImageCollection : UICollectionView

/** 支持UIImage,NSString类型 */
@property (nonatomic,strong,readonly) NSMutableArray* images;

/** 是否可编辑 删除、添加图片 默认NO */
@property (nonatomic,assign) IBInspectable BOOL editing;
/** 最大图片张数 */
@property (nonatomic,assign) IBInspectable NSUInteger maxCount;
/** 代理对象*/
@property (nonatomic,assign) id<KSImageCollectionDelegate> target;

/** 初始化一个图片数组，类型可以为自定义类型，需要指定Image的属性*/
- (void)setImageModelArray:(NSArray*)array property:(NSString*)property;
/** 初始化一个图片，类型可以为UImage,NSString*/
- (void)setImage:(id)image;
/** 初始化一个图片数组，类型可以为UImage,NSString*/
- (void)setImageArray:(NSArray *)array;

/** 添加一个图片数组，类型可以为自定义类型，需要指定Image的属性*/
- (void)addImageModelArray:(NSArray*)array property:(NSString*)property;
/** 添加一个图片，类型可以为UImage,NSString*/
- (void)addImage:(id)image;
/** 添加一个图片数组，类型可以为UImage,NSString*/
- (void)addImageArray:(NSArray *)array;

/** 指定位置插入一个图片数组，类型可以为自定义类型，需要指定Image的属性*/
- (void)insertImageModelArray:(NSArray*)array property:(NSString*)property atIndex:(NSUInteger)index;
/** 指定位置插入一个图片，类型可以为UImage,NSString*/
- (void)insertImage:(id)image atIndex:(NSUInteger)index;
/** 指定位置插入一个图片数组，类型可以为UImage,NSString*/
- (void)insertImageArray:(NSArray *)array atIndex:(NSUInteger)index;

/** 删除所有图片*/
- (void)removeAllImages;

@end

