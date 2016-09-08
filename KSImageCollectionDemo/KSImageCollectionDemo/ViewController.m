//
//  ViewController.m
//  KSImageCollectionDemo
//
//  Created by kong on 16/9/7.
//  Copyright © 2016年 孔. All rights reserved.
//

#import "ViewController.h"
#import "KSTableViewCell1.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.tableView registerClass:[KSTableViewCell1 class] forCellReuseIdentifier:@"KSTableViewCell1"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KSTableViewCell1* cell = [tableView dequeueReusableCellWithIdentifier:@"KSTableViewCell1"];
    
    NSArray* array = @[@"http://image.tianjimedia.com/uploadImages/2012/231/00/0588TRI5TMQS.jpg",
                       @"http://image.tianjimedia.com/uploadImages/2015/129/56/J63MI042Z4P8.jpg",
                       @"http://image.tianjimedia.com/uploadImages/2012/233/32/383NF7SDB8CR.jpg",
                       @"http://image.tianjimedia.com/uploadImages/2012/229/15/59JY571XPP12.jpg",
                       @"http://pic35.nipic.com/20131121/2531170_145358633000_2.jpg",
                       @"http://image.tianjimedia.com/uploadImages/2012/231/00/0588TRI5TMQS.jpg",
                       @"http://image.tianjimedia.com/uploadImages/2015/129/56/J63MI042Z4P8.jpg",
                       @"http://image.tianjimedia.com/uploadImages/2012/233/32/383NF7SDB8CR.jpg",
                       @"http://image.tianjimedia.com/uploadImages/2012/229/15/59JY571XPP12.jpg",
                       @"http://pic35.nipic.com/20131121/2531170_145358633000_2.jpg"];
    cell.imageArray = array;
    
    return cell;
}

@end
