//
//  KSImageCollection.m
//  MarryMe
//
//  Created by kong on 16/6/22.
//  Copyright © 2016年 孔令硕. All rights reserved.
//

#import "KSImageCollection.h"
#import "KSImageCollectionCell.h"
#import "KSImageCollectionFooterHeader.h"

#define ITEM_SIZE (CGSizeMake(self.bounds.size.height - .5,self.bounds.size.height - .5))

#pragma mark-
#pragma mark KSImageCollection

@interface KSImageCollection ()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout,
    KSImageCollectionCellDelegate,
    KSImageCollectionFooterHeaderDelegate
>

@property (nonatomic, strong) UICollectionViewFlowLayout* layout;
@end

@implementation KSImageCollection

- (instancetype)init
{
    self = [super initWithFrame:CGRectZero collectionViewLayout:self.layout];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)awakeFromNib{
    
    self.collectionViewLayout = self.layout;
    [self setupSubviews];
    
}

- (UICollectionViewFlowLayout*)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.minimumLineSpacing = 5;
        _layout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
    }
    return _layout;
}

- (void)setupSubviews{
    
    _images = [[NSMutableArray alloc] init];
    
    self.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    self.dataSource = self;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    
    [self registerClass:[KSImageCollectionCell class] forCellWithReuseIdentifier:@"KSImageCollectionCell"];
    [self registerClass:[KSImageCollectionFooterHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:UICollectionElementKindSectionFooter];
    [self registerClass:[KSImageCollectionFooterHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:UICollectionElementKindSectionHeader];
}

#pragma mark- UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KSImageCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KSImageCollectionCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.imageObject = _images[indexPath.row];
    cell.editing = _editing;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (_images.count >= _maxCount || (!_editing)) {
        return nil;
    }
    
    KSImageCollectionFooterHeader* footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kind forIndexPath:indexPath];
    footer.delegate = self;
    return footer;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return ITEM_SIZE;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    if (_images.count >= _maxCount || _unEditable) {
//        return CGSizeZero;
//    }
//    return ITEM_SIZE;
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (_images.count >= _maxCount || (!_editing)) {
        return CGSizeZero;
    }
    return ITEM_SIZE;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    id imageObj = _images[indexPath.row];
        
    if (_target && [_target respondsToSelector:@selector(ks_imageCollection:didSelectImage:atIndex:)]) {
        [_target ks_imageCollection:self didSelectImage:imageObj atIndex:indexPath.row];
    }
}

- (void)ks_imageCollectionFooterHeaderDidClick{
    if (_target && [_target respondsToSelector:@selector(ks_imageCollection:shouldAddImageAtIndex:)]) {
        [_target ks_imageCollection:self shouldAddImageAtIndex:self.images.count - 1];
    }
}

- (void)ks_imageCollectionCell:(KSImageCollectionCell *)cell didClickRemoveObject:(id)object atIndex:(NSUInteger)index{
    
    id imageObj = self.images[index];
    
    if (_target && [_target respondsToSelector:@selector(ks_imageCollection:willDeleteImage:atIndex:)]) {
        [_target ks_imageCollection:self willDeleteImage:imageObj atIndex:index];
    }
    
    [self.images removeObjectAtIndex:index];
    [self reloadData];
}


- (void)setImageArray:(NSArray *)array{
    [self.images removeAllObjects];
    [self addImageArray:array];
}
- (void)setImage:(id)image{
    [self.images removeAllObjects];
    [self addImageArray:@[image]];
}
- (void)setImageModelArray:(NSArray *)array property:(NSString *)property{
    [self.images removeAllObjects];
    [self addImageModelArray:array property:property];
}

- (void)addImage:(id)image{
    [self.images addObject:image];
    [self reloadData];
}
- (void)addImageArray:(NSArray *)array{
    [self.images addObjectsFromArray:array];
    [self reloadData];
}
- (void)addImageModelArray:(NSArray *)array property:(NSString *)property{
    [self addImageArray:[array valueForKeyPath:property]];
}

- (void)insertImage:(id)image atIndex:(NSUInteger)index{
    [self.images insertObject:image atIndex:index];
//    [self insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]];
    [self reloadData];
}
- (void)insertImageArray:(NSArray *)array atIndex:(NSUInteger)index{
    [self.images insertObjects:array atIndexes:[NSIndexSet indexSetWithIndex:index]];
    [self reloadData];
}
- (void)insertImageModelArray:(NSArray *)array property:(NSString *)property atIndex:(NSUInteger)index{
    [self.images insertObjects:[array valueForKeyPath:property] atIndexes:[NSIndexSet indexSetWithIndex:index]];
    [self reloadData];
}

- (void)removeAllImages{
    [self.images removeAllObjects];
    
    [self reloadData];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

