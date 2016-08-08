//
//  BWHomeViewController.m
//  BWUtilityFunction
//
//  Created by BobWong on 16/8/3.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import "BWHomeViewController.h"
#import "BWLocalizeViewController.h"

@interface BWHomeViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSArray *_dataSource;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Utility Function";
    
    _dataSource = @[@"Internationalization"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [self performSegueWithIdentifier:@"push_to_internationalization" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *vc = segue.destinationViewController;
    vc.view.backgroundColor = [UIColor whiteColor];
    
    if ([vc isKindOfClass:[BWLocalizeViewController class]]) {
        BWLocalizeViewController *vcLocalize = (BWLocalizeViewController *)vc;
        vcLocalize.blockResetVC = ^ {
            [self.navigationController popViewControllerAnimated:YES];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self performSegueWithIdentifier:@"push_to_internationalization" sender:self];
            });
        };
    }
}

@end
