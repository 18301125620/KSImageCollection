//
//  ViewController.m
//  KSImageCollectionDemo
//
//  Created by kong on 16/9/7.
//  Copyright © 2016年 孔. All rights reserved.
//

#import "ViewController.h"
#import "KSTableViewCell1.h"
#import "KSImageCollection.h"

@interface ViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
KSTableViewCell1Delegate
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<NSMutableArray*> *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.tableView registerClass:[KSTableViewCell1 class] forCellReuseIdentifier:@"KSTableViewCell1"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KSTableViewCell1* cell = [tableView dequeueReusableCellWithIdentifier:@"KSTableViewCell1"];
    
    cell.imageArray = self.dataSource[indexPath.row];
    cell.delegate = self;
    
    return cell;
}
#pragma mark-
#pragma mark KSTableViewCell1Delegate
- (void)ks_tableViewCell:(KSTableViewCell1*)cell willDeleteAtIndexPath:(NSIndexPath*)indexPath{
    NSLog(@"删除图片:%@",indexPath);
    [self.dataSource[indexPath.section] removeObjectAtIndex:indexPath.row];
}

- (void)ks_tableViewCell:(KSTableViewCell1*)cell didSelectAtIndexPath:(NSIndexPath*)indexPath{
    NSLog(@"点击图片:%@",indexPath);
}

- (void)ks_tableViewCell:(KSTableViewCell1*)cell shouldAddImageAtIndexPath:(NSIndexPath*)indexPath{
    NSLog(@"添加图片:%@",indexPath);
}

#pragma mark-
#pragma mark setting
- (NSMutableArray<NSMutableArray *> *)dataSource{
    if (!_dataSource) {
        _dataSource  = [NSMutableArray array];
        for (int i = 0; i < 20; i ++) {
            NSMutableArray* array = [NSMutableArray arrayWithArray:
                                     @[@"http://image.tianjimedia.com/uploadImages/2012/231/00/0588TRI5TMQS.jpg",
                                       @"http://image.tianjimedia.com/uploadImages/2015/129/56/J63MI042Z4P8.jpg",
                                       @"http://image.tianjimedia.com/uploadImages/2012/233/32/383NF7SDB8CR.jpg",
                                       @"http://image.tianjimedia.com/uploadImages/2012/229/15/59JY571XPP12.jpg",
                                       @"http://pic35.nipic.com/20131121/2531170_145358633000_2.jpg",
                                       @"http://image.tianjimedia.com/uploadImages/2012/231/00/0588TRI5TMQS.jpg",
                                       @"http://image.tianjimedia.com/uploadImages/2015/129/56/J63MI042Z4P8.jpg",
                                       @"http://image.tianjimedia.com/uploadImages/2012/233/32/383NF7SDB8CR.jpg",
                                       @"http://image.tianjimedia.com/uploadImages/2012/229/15/59JY571XPP12.jpg",
                                       @"http://pic35.nipic.com/20131121/2531170_145358633000_2.jpg"]];
            [_dataSource addObject:array];
        }
    }
    return _dataSource;
}

@end
