//
//  TwoVC.m
//  JHKeyBoardManager
//
//  Created by 黄俊煌 on 2017/8/23.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "TwoVC.h"
//#import "UIViewController+KeyBoardManager.h"
#import "ThreeVC.h"

@interface TwoVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TwoVC

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"";
    [self.view addSubview:self.tableView];
//    [self transformViewForKeyboard];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}

#pragma mark - Public Methods



#pragma mark - Private Methods

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 10, 150, 50)];
    textField.backgroundColor = [UIColor brownColor];
    [cell.contentView addSubview:textField];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
    if (indexPath.row == 0) {
        ThreeVC *vc = [ThreeVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (_tableView) return _tableView;
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    return _tableView;
}

#pragma mark - Setter

@end
