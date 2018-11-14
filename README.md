# BmobDemo
Bmon data service
## 一、介绍
Bmob后端云提供可视化的云端数据表设计界面，轻松建库建表。支持10种不同数据类型存储：如字符串，整型，数组等。
![1.jpg](https://upload-images.jianshu.io/upload_images/4905848-5e0d092fe20de3f0.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> 声明不是为此服务打广告，只是介绍使用

## 二、简单使用

 1. 注册Bmob帐号
在网址栏输入www.bmob.cn或者在百度输入Bmob进行搜索，打开Bmob官网后，点击右上角的“注册”，在跳转页面填入你的姓名、邮箱、设置密码，确认后到你的邮箱激活Bmob账户，你就可以用Bmob轻松开发应用了。
![注册.png](https://upload-images.jianshu.io/upload_images/4905848-85235b977fd973f0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

 2. 网站后台创建应用
登录账号进入bmob后台后，点击后台界面左上角“创建应用”，在弹出框输入你应用的名称，然后确认，你就拥有了一个等待开发的应用。
![rumen_chuangjian.png](https://upload-images.jianshu.io/upload_images/4905848-abc102e196cee053.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

 3. 获取应用密钥和下载SDK
选择你要开发的应用，进入该应用
![rumen_miyue_1.png](https://upload-images.jianshu.io/upload_images/4905848-fd3c91e3d1d17cee.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

在跳转页面，进入设置/应用密钥，点击复制，即可得到Application ID
![![11.png](https://upload-images.jianshu.io/upload_images/4905848-d2d809a4c12c4fd5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
](https://upload-images.jianshu.io/upload_images/4905848-8baec04abdfe881c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

获取Application ID后，下载SDK，开发者可以根据自己的需求选择相应的iOS SDK 或Android SDK，点击下载即可。

## 三、iOS端集成SDK方式

 1.  直接下载SDK导入到项目中
 -  将BmobSDK引入项目:
在你的XCode项目工程中，添加BmobSDK.framework

 - 添加使用的系统framework:

在你的XCode工程中Project ->TARGETS -> Build Phases->Link Binary With Libraries引入
CoreLocation.framework、Security.framework、CoreGraphics.framework、MobileCoreServices.framework、CFNetwork.framework、CoreTelephony.framework、SystemConfiguration.framework、libz.1.2.5.tbd、libicucore.tbd、libsqlite3.tbd、libc++.tbd、photos.framework
 

 2. 通过Pods导入，在`Podfile`中写入
 ```Object-C
platform :ios,'9.0'
target 'BmopDataDemo' do
pod 'BmobSDK'
end
 ```
之后执行`Pod install`命令进行安装

## 四、iOS简单使用

 1. 设置应用的BmobKey
在你的XCode工程中的AppDelegate.m文件中创建应用Key，填入申请的授权Key（SDK使用的是应用密钥里的Application ID），示例如下：
> 需要在Bmob控制台先创建表，然后才可进行查删改增的操作

```Objective-C
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [Bmob registerWithAppKey:@"申请的Application ID"];
    return YES;
}
```
2. 添加一条数据
  ``` Objective-C
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
  ```

 3. 查询一条数据
 ``` Objective - C
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
 ```
 4. 删除一条数据
 ```Objective-C
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
 ```
## Bmob控制台
![11.png](https://upload-images.jianshu.io/upload_images/4905848-f0452e70e561516e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

其他操作请参考官方文档。
代码上传至[GittHub](https://github.com/chuzhaozhi/BmobDemo),欢迎star
[更多文章](http://chuzhaozhi.cn)
关注公众号`JackerooChu`获取更多文章资源。
![swap.png](https://upload-images.jianshu.io/upload_images/4905848-c82ef7d8c11ba86c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
