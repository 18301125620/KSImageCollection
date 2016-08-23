//
//  KSImageCollection.m
//  MarryMe
//
//  Created by kong on 16/6/22.
//  Copyright © 2016年 XiaoFanChuan. All rights reserved.
//

#import "KSImageCollection.h"
#import <UIImageView+WebCache.h>

#define MAX_COUNT (9)
#define ITEM_SIZE (CGSizeMake(self.bounds.size.height - .5,self.bounds.size.height - .5))

/***********************************************************************************************
 *****************************************************************************************************/

/**
 *  选择图片按钮
 */
@interface KSImageCollectionFooter : UICollectionReusableView

@end

/***********************************************************************************************
 *****************************************************************************************************/

/**
 *  展示图片
 */
@interface KSImageCollectionCell : UICollectionViewCell

@property (nonatomic,strong) id imageObject;
@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic,assign) BOOL Uneditable;

@end

/***********************************************************************************************
 *****************************************************************************************************/

@interface KSImageCollection ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation KSImageCollection

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}
- (void)awakeFromNib{
    [self setupSubviews];
}

- (void)setupSubviews{
    
    _imageArray = [[NSMutableArray alloc] init];
    
    self.delegate = self;
    self.dataSource = self;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    
    UICollectionViewFlowLayout* flow = [[UICollectionViewFlowLayout alloc] init];
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.minimumLineSpacing = 5;
    flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 5);
    self.collectionViewLayout = flow;
    
    flow.itemSize = ITEM_SIZE;
    
    [self registerClass:[KSImageCollectionCell class] forCellWithReuseIdentifier:@"KSImageCollectionCell"];
    [self registerClass:[KSImageCollectionFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"KSImageCollectionFooter"];
    
    //监听imageArray变化

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willDeleteImageNotifition:) name:KSImageCollectionWillDeleteImageNotifition object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldAddImageNotifition:) name:KSImageCollectionShouldAddImageNotifition object:nil];

}


#pragma mark- UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArray.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KSImageCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KSImageCollectionCell" forIndexPath:indexPath];
    
    cell.imageObject = _imageArray[indexPath.row];
    cell.Uneditable = _Uneditable;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (_imageArray.count >= MAX_COUNT || _Uneditable) {
        return nil;
    }
    
    KSImageCollectionFooter* footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"KSImageCollectionFooter" forIndexPath:indexPath];
    return footer;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (_imageArray.count >= MAX_COUNT || _Uneditable) {
        return CGSizeZero;
    }
    return ITEM_SIZE;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    id imageObj = _imageArray[indexPath.row];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KSImageCollectionDidSelectImageNotifition object:imageObj userInfo:@{@"index":@(indexPath.row)}];
    
    if (_target && [_target respondsToSelector:@selector(ks_imageCollection:DidSelectImage:atIndex:)]) {
        [_target ks_imageCollection:self DidSelectImage:imageObj atIndex:indexPath.row];
    }
}

- (void)willDeleteImageNotifition:(NSNotification*)not{
    
    NSNumber* index = not.userInfo[@"index"];

    id imageObj = self.imageArray[[index unsignedIntegerValue]];
    
    if (_target && [_target respondsToSelector:@selector(ks_imageCollection:WillDeleteImage:atIndex:)]) {
        [_target ks_imageCollection:self WillDeleteImage:imageObj atIndex:[index unsignedIntegerValue]];
    }
    
    [self.imageArray removeObjectAtIndex:[index integerValue]];
    [self reloadData];
}

- (void)shouldAddImageNotifition:(NSNotification*)not{
    if (_target && [_target respondsToSelector:@selector(ks_imageCollection:ShouldAddImageAtIndex:)]) {
        [_target ks_imageCollection:self ShouldAddImageAtIndex:self.imageArray.count - 1];
    }
}

- (void)addImage:(id)image{
    
    [self.imageArray addObject:image];
    [self reloadData];
    
}

- (void)addImageArray:(NSArray *)array{
    [self.imageArray addObjectsFromArray:array];
    [self reloadData];
}

- (void)addImageModelArray:(NSArray *)array property:(NSString *)property{
    
    dispatch_async(dispatch_queue_create("com.KSImageCollection", DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
        
        NSMutableArray* urls = [NSMutableArray array];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [urls addObject:[obj valueForKey:property]];
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addImageArray:urls];
        });
    });
}

- (void)removeAllImages{
    [self.imageArray removeAllObjects];
    [self reloadData];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

/***********************************************************************************************
 *****************************************************************************************************/
/***********************************************************************************************
 *****************************************************************************************************/

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
        [btn setBackgroundImage:[UIImage imageNamed:@"Shape"] forState:UIControlStateNormal];
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

- (void)setUneditable:(BOOL)Uneditable{
    _Uneditable = Uneditable;
    [self.contentView viewWithTag:100].hidden = Uneditable;
}

- (void)removeImage:(UIButton*)sender{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KSImageCollectionWillDeleteImageNotifition object:_imageObject userInfo:@{@"index":@(self.indexPath.row)}];

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


/***********************************************************************************************
 *****************************************************************************************************/
/***********************************************************************************************
 *****************************************************************************************************/

@implementation KSImageCollectionFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectInset(self.bounds, 5, 5);
        [btn setBackgroundImage:[UIImage imageNamed:KSImageCollectAdd] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}

- (void)selectImage:(UIButton*)sender{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KSImageCollectionShouldAddImageNotifition object:nil userInfo:nil];
}
@end


NSString* const KSImageCollectionWillDeleteImageNotifition = @"KSImageCollectionWillDeleteImageNotifition";
NSString* const KSImageCollectionDidSelectImageNotifition = @"KSImageCollectionDidSelectImageNotifition";
NSString* const KSImageCollectionShouldAddImageNotifition = @"KSImageCollectionShouldAddImageNotifition";
