//
//  ViewController.m
//  BmopDataDemo
//
//  Created by chuzhaozhi on 2018/11/13.
//  Copyright © 2018 JackerooChu. All rights reserved.
//
#import <BmobSDK/Bmob.h>
#import "ViewController.h"
@interface ViewController ()
@property (nonatomic,strong) UILabel *showInfo;
@property (nonatomic,copy) NSString *userId;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *add = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 44)];
    [add setTitle:@"add" forState:UIControlStateNormal];
    [add setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

    [add addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:add];
    UIButton *search = [[UIButton alloc] initWithFrame:CGRectMake(100, 150, 100, 44)];
    [search setTitle:@"search" forState:UIControlStateNormal];
    [search setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

    [search addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:search];
    UIButton *delete = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 44)];
    [delete setTitle:@"delete" forState:UIControlStateNormal];
    [delete setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

    [delete addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:delete];
    self.showInfo = [[UILabel alloc] initWithFrame:CGRectMake(100, 500, 200, 100)];
    self.showInfo.textColor = [UIColor blackColor];
    self.showInfo.text =@"显示信息";
    [self.view addSubview:self.showInfo];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)addAction:(UIButton *)add{
    BmobObject *gameScore = [BmobObject objectWithClassName:@"Customer"];
    [gameScore setObject:@"小明" forKey:@"UserName"];
    [gameScore setObject:@"1993-07-22" forKey:@"UserBirthDay"];
    [gameScore setObject:@YES forKey:@"Sex"];
    [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        //进行操作
        if (isSuccessful) {
            self.userId = gameScore.objectId;
            self.showInfo.text =@"添加成功";
        }else{
            self.showInfo.text =@"添加失败";
        }
    }];
}
-(void)searchAction:(UIButton *)search{
    //查找GameScore表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Customer"];
    //查找GameScore表里面id为0c6db13c的数据
    [bquery getObjectInBackgroundWithId:self.userId block:^(BmobObject *object,NSError *error){
        if (error){
            //进行错误处理
        }else{
            //表里有id为0c6db13c的数据
            if (object) {
                //得到playerName和cheatMode
                NSString *playerName = [object objectForKey:@"UserName"];
                BOOL cheatMode = [[object objectForKey:@"cheatMode"] boolValue];
                NSLog(@"%@----%i",playerName,cheatMode);
                 self.showInfo.text =playerName;
            }
        }
    }];
}
-(void)deleteAction:(UIButton *)delete{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Customer"];
    [bquery getObjectInBackgroundWithId:self.userId block:^(BmobObject *object, NSError *error){
        if (error) {
            //进行错误处理
        }
        else{
            if (object) {
                //异步删除object
                [object deleteInBackground];
                self.showInfo.text =@"删除成功";
            }
        }
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
}

@end
