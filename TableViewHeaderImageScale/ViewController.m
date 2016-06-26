//
//  ViewController.m
//  TableViewHeaderImageScale
//
//  Created by hzzc on 16/6/26.
//  Copyright © 2016年 hzzc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIImageView *HeaderImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITableView *table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:table];
    
    UIView *titleView = [[UIView alloc]init];
    self.navigationItem.titleView = titleView;
    
    self.HeaderImage = [[UIImageView alloc]init];
    self.HeaderImage.image = [UIImage imageNamed:@"ICON.png"];
    self.HeaderImage.frame = CGRectMake(0, 0, 80, 80);
    self.HeaderImage.layer.cornerRadius = 40;
    self.HeaderImage.layer.masksToBounds = YES;
    self.HeaderImage.center = CGPointMake(titleView.center.x, 0);
    [titleView addSubview:self.HeaderImage];
   
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 允许下拉放大的最大距离为300
    // 1.5是放大的最大倍数，当达到最大时，大小为：1.5 * 70 = 105
    // 这个值可以自由调整
    CGFloat offSetY = scrollView.contentOffset.y + scrollView.contentInset.top;
    
    NSLog(@"offSetY = %f Y = %f top = %f",offSetY,scrollView.contentOffset.y,scrollView.contentInset.top);
    
    CGFloat scale = 1.0;
    if (offSetY < 0) {
        scale = MIN(1.5, 1 - offSetY / 300);
    }else if(offSetY > 0){
        
        // 允许向上超过导航条缩小的最大距离为300
        // 为了防止缩小过度，给一个最小值为0.45，其中0.45 = 31.5 / 70.0，表示
        // 头像最小是31.5像素

        scale = MAX(0.45, 1 - offSetY / 300);
    }
    self.HeaderImage.transform = CGAffineTransformMakeScale(scale, scale);
    
    //确保缩放后的坐标不变
    CGRect frame = self.HeaderImage.frame;
    frame.origin.y = -self.HeaderImage.layer.cornerRadius / 2;
    self.HeaderImage.frame = frame;
    
    
}

#pragma mark - TableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 50;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        cell.textLabel.text = @"测试代码,看效果如何啊！！！！";
    
    return cell;
}
@end
