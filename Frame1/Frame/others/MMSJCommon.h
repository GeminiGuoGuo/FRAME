//
//  MMSJConstant.h
//  MMTestDriveClient
//
//  Created by yh on 15/3/17.
//  Copyright (c) 2015年 MMSJ. All rights reserved.
//

#ifndef MMTestDriveClient_MMSJConstant_h
#define MMTestDriveClient_MMSJConstant_h


#import "SystemManager.h"
#import "HttpManager.h"
#import "MMSJViewController.h"
#import "MMSJTableViewController.h"
#import "SVProgressHUD.h"
#import "MMSJInterfaceDoc.h"
#import "MMSJNotificationDoc.h"
#import "MJExtension.h"
#import "UIBarButtonItem+MMSJ.h"
#import "MBProgressHUD.h"

#define Rect_Make(Left,Top,Width,Hight) CGRectMake(Left,Top,Width,Hight)
#define LCImage(ImageName) [UIImage imageNamed:ImageName]

#define ImgPlaceHolder [UIImage imageNamed:@"smallplaceholder"]


#define NSLog(FORMAT, ...) fprintf(stdout,"[NSLOG] [类名：%s : 第%d行的NSLog] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);



#define IOS7 ([[UIDevice currentDevice] systemVersion].floatValue >=7.0)
//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width


#define OutIp     @""

#define Scale ScreenWidth/320.0
#define CREAT_COLOR(R,G,B,ALPHA) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:ALPHA]
#define RightString(str) !str?@"":str


/*******登录注册校验********/
#define Mobile_EmptError     @"手机号码不能为空"
#define Mobile_LengthError     @"手机号码格式不正确"
#define MessageCode_EmptError     @"验证码不能为空"
#define MessageCode_LengthError     @"验证码格式不正确"
#define Password_EmptError     @"密码不能为空"
#define Password_LengthError     @"密码格式不正确"
#define Email_EmptError     @"邮箱不能为空"
#define Email_LengthError     @"邮箱格式不正确"
#define MessageCodeEndMessage  @"获取验证码"


/**
 *  快速weak
 */
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;


/**
 *  屏幕宽
 */
#define SCRWidth      ([UIScreen mainScreen].bounds.size.width)
/**
 *  屏幕高
 */
#define SCRHeight      ([UIScreen mainScreen].bounds.size.height)


#define gFTHUDFontSize  15

/**
 *  HUD自动隐藏
 *
 */
#define HUDNormal(msg) {MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:NO];\
hud.mode = MBProgressHUDModeText;\
hud.minShowTime=1;\
hud.detailsLabelText= msg;\
hud.detailsLabelFont = [UIFont systemFontOfSize:gFTHUDFontSize];\
[hud hide:YES afterDelay:1];\
}

/**
 *  HUD不自动隐藏
 *
 */
#define HUDNoStop(msg)    {MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:NO];\
hud.detailsLabelText = msg;\
hud.detailsLabelFont = [UIFont systemFontOfSize:gFTHUDFontSize];\
hud.mode = MBProgressHUDModeText;}


//字符串拼接
#define GETSTRING_WITH(x,y) [NSString stringWithFormat:@"%@%@",x,y]


/**
 *  SVHUD 展示 默认隐藏
 *
 */
#define SVHUD_Normal(meg)   {\
[SVProgressHUD showWithStatus:meg];\
[SVProgressHUD dismissAfterDelay:1];\
}
/**
 *  SVHUD 展示 默认不隐藏
 *
 */
#define SVHUD_NO_Stop(meg) {\
[SVProgressHUD showWithStatus:meg];\
}
/**
 *  SVHUD 隐藏
 *
 */
#define SVHUD_Stop [SVProgressHUD dismiss];
/**
 *  SVHUD 请求失败
 */
#define SVHUD_HTTP_ERROR [SVProgressHUD showErrorWithStatus:@"请求失败"];
/**
 *  SVHUD 请求成功
 */
#define SVHUD_HTTP_SUCCESS(msg) [SVProgressHUD showSuccessWithStatus:msg?msg:@"请求成功"];
/**
 *  SVHUD 提示
 */
#define SVHUD_HINT(msg) [SVProgressHUD showInfoWithStatus:msg];

#define SVHUD_BadNetwork    SVHUD_HINT(@"网络不太好哟,请稍后重试")



//tabbar 的颜色 以及透明度
#define Tabbar_COLOR [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]

//tabbar 的图片的高度所占比例
#define Tabbar_Image_Scale 1.0

//tabbar文字未选中状态下的颜色
#define Tabbar_Text_COLOR [UIColor colorWithRed:98/255.0 green:98/255.0 blue:98/255.0 alpha:1.0]

//tabbar文字选中状态下的颜色
#define Tabbar_TextSel_COLOR [UIColor colorWithRed:107/255.0 green:169/255.0 blue:226/255.0 alpha:1.0]

//tabbar 的文字的大小(不加粗)
#define Tabbar_Font [UIFont systemFontOfSize:10]
//tabbar 的文字的大小(加粗)
#define Tabbar_Bold_Font [UIFont boldSystemFontOfSize:15]




//navigation导航条的颜色
#define Navigation_COLOR [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]
//navigation中间字体的颜色的颜色
#define Navigation_Text_COLOR [UIColor colorWithRed:107/255.0 green:169/255.0 blue:226/255.0 alpha:1.0]

//navigation 中间文字的大小(不加粗)
#define Navigation_Font [UIFont systemFontOfSize:20];
//navigation 中间文字的大小(加粗)
#define Navigation_Bold_Font [UIFont boldSystemFontOfSize:20];

//返回键图片的名字
#define Navigation_back_image @"Shape-35";
;



#endif
