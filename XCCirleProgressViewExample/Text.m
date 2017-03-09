//
//  Text.m
//  圆形进度圈
//
//  Created by 樊小聪 on 16/6/6.
//  Copyright © 2016年 樊小聪. All rights reserved.
//

#import "Text.h"
#import "TableViewCell.h"

@interface Text ()

@end

@implementation Text

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 667;
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.first.progress = 0.75;
    cell.two.progress   = 1;
    
    return cell;
}


@end
