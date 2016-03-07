//
//  TakePhoto.h
//  QianXiaZiMember
//
//  Created by 张博 on 14/11/28.
//  Copyright (c) 2014年 lcworld. All rights reserved.
//

typedef void(^SelectPhotosBlock)(NSArray * photosArray);
#import <Foundation/Foundation.h>
#import "ELCImagePickerController.h"
#import "ELCAssetTablePicker.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
/**获取照片，拍照或者选取相册*/
@interface TakePhoto : NSObject<ELCImagePickerControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) ALAssetsLibrary *specialLibrary;
@property (nonatomic, assign) BOOL isSingle;

@property (nonatomic, assign) UIViewController * presentController;
@property (nonatomic, copy) SelectPhotosBlock resultBlock;

/*弹出选择照片sheet*/
-(void)showSheetWithController:(UIViewController *)controller selectCount:(int)count;

/*从照片库中查找照片**/
-(void)takePhotoFromLibraryWithController:(UIViewController *)controller count:(NSInteger)count;
/*从相机中查找照片*/
-(void)takePhotoFromCameraWithController:(UIViewController *)controller;
@end
