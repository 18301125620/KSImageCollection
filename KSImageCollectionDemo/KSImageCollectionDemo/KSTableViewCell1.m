//
//  KSTableViewCell1.m
//  KSImageCollectionDemo
//
//  Created by kong on 16/9/7.
//  Copyright © 2016年 孔. All rights reserved.
//

#import "KSTableViewCell1.h"
#import "KSImageCollection.h"

@interface KSTableViewCell1 ()

@property (nonatomic, strong) KSImageCollection* imageCollection;

@end

@implementation KSTableViewCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.imageCollection = [[KSImageCollection alloc] init];
        self.imageCollection.maxCount = 100;
//        self.imageCollection.editing = YES;
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
@end
