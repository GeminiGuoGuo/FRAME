//
//  TakePhoto.m
//  QianXiaZiMember
//
//  Created by 张博 on 14/11/28.
//  Copyright (c) 2014年 lcworld. All rights reserved.
//

#import "TakePhoto.h"
#import "IBActionSheet.h"
@implementation TakePhoto
/*弹出选择照片sheet*/
-(void)showSheetWithController:(UIViewController *)controller selectCount:(int)count
{
    self.presentController = controller;
    __weak TakePhoto * weakSelf = self;
    IBActionSheet * sheet = [[IBActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle: nil otherButtonTitles:@"打开相机",@"打开相册", nil];
    [sheet setFont:[UIFont systemFontOfSize:13]];
    if (self.presentController.navigationController) {
        [sheet showInView:self.presentController.navigationController.view];
    }else
    {
        [sheet showInView:self.presentController.view];
    }
    
    sheet.sheetBlock = ^(IBActionSheet * sheet, NSInteger buttonIndex)
    {
        if (buttonIndex == 0) //打开相机
        {
            [weakSelf takePhotoFromCameraWithController:weakSelf.presentController];
        }else if (buttonIndex == 1) //打开相册
        {
            [weakSelf takePhotoFromLibraryWithController:weakSelf.presentController count:count];
        }
    };
}

/*从照片库中查找照片**/
-(void)takePhotoFromLibraryWithController:(UIViewController *)controller count:(NSInteger)count
{
    self.presentController = controller;
    __weak TakePhoto * weakSelf = self;
    if (count == 1) {
        self.isSingle = YES;
    }else
    {
        self.isSingle = NO;
    }
    if (self.isSingle) //选择单张图片
    {
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        self.specialLibrary = library;
        NSMutableArray *groups = [NSMutableArray array];
        [self.specialLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            if (group) {
                [groups addObject:group];
            } else {
                // this is the end
                [weakSelf displayPickerForGroup:groups[0]];
            }
        } failureBlock:^(NSError *error) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"读取图片出现错误"] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
            [alert show];
            
            NSLog(@"A problem occured %@", [error description]);
        }];
    }
    else //选择多张图片
    {
        ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
        
        elcPicker.maximumImagesCount = count; //Set the maximum number of images to select to 100
        elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
        elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
        elcPicker.onOrder = YES; //For multiple image selection, display and return order of selected images
        elcPicker.mediaTypes = @[(NSString *)kUTTypeImage]; //Supports image and movie types
        
        elcPicker.imagePickerDelegate = self;
        [self.presentController presentViewController:elcPicker animated:YES completion:^{
            
        }];
    }
}


- (void)displayPickerForGroup:(ALAssetsGroup *)group
{
    ELCAssetTablePicker *tablePicker = [[ELCAssetTablePicker alloc] initWithStyle:UITableViewStylePlain];
    tablePicker.singleSelection = YES;
    tablePicker.immediateReturn = YES;
    
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:tablePicker];
    elcPicker.maximumImagesCount = 1;
    elcPicker.imagePickerDelegate = self;
    elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = NO; //For single image selection, do not display and return order of selected images
    tablePicker.parent = elcPicker;
    // Move me
    tablePicker.assetGroup = group;
    [tablePicker.assetGroup setAssetsFilter:[ALAssetsFilter allAssets]];
    [self.presentController presentViewController:elcPicker animated:YES completion:nil];
}

/*返回回调**/
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    __weak TakePhoto * weakSelf = self;
    [self.presentController dismissViewControllerAnimated:YES completion:^{
        
        NSMutableArray *images = [NSMutableArray arrayWithCapacity:[info count]];
        
        for (NSDictionary *dict in info)
        {
            if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto)
            {
                if ([dict objectForKey:UIImagePickerControllerOriginalImage])
                {
                    UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                    [images addObject:image];
                    
                    if ([images count]==[info count])
                    {
                        if (weakSelf.resultBlock)
                        {
                            weakSelf.resultBlock(images);
                        }
                    }
                    
                }
                else
                {
                    NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
                }
            }
        }
    }];
    
    
    
}
- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self.presentController dismissViewControllerAnimated:YES completion:nil];
}


/*从相机中查找照片*/
-(void)takePhotoFromCameraWithController:(UIViewController *)controller
{
    //    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
    //        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //    }
    //    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    //    picker.delegate =self;
    //    picker.allowsEditing = YES;
    //    picker.sourceType = sourceType;
    //    [controller presentViewController:picker animated:YES completion:^{
    //    }];
    UIImagePickerController * imagePicker;
    if (imagePicker==nil) {
        imagePicker=[[UIImagePickerController alloc]init];
        imagePicker.delegate=self;
        imagePicker.allowsEditing = YES;
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
        [controller presentViewController:imagePicker animated:YES completion:^{
            
        }];
    }
    else {
        UIAlertView *cameraAlert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您的设备不支持相机" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [cameraAlert show];
    }
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    __weak TakePhoto * weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        if (weakSelf.resultBlock) {
            weakSelf.resultBlock(@[image]);
        }
    }];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


-(void)dealloc
{
    
}
@end
