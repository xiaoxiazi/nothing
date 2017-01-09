//
//  UIImage+QRCode.h
//  11-生成二维码
//
//  Created by HQL on 16/6/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QRCode)

/**
 根据内容生成二维码

 @param content 传入生成二维码的内容
 @return 返回二维码图片
 */
+(UIImage *) qrCodeImageWithContent:(NSString *) content;


/**
 生成带有前景色以及后景色不带头像的二维码

 @param content 传入生成二维码的内容
 @param foregroundColor 前背景色
 @param backgroundColor 后背景色
 @return 返回二维码图片
 */
+(UIImage *) qrCodeImageWithContent:(NSString *)content foregroundColor:(UIColor *) foregroundColor  andBackgroundColor:(UIColor *) backgroundColor;

/**
 生成带有头像的二维码

 @param content 传入生成二维码的内容
 @param headImageName 中间头像图片名称
 @return 返回二维码图片
 */
+(UIImage *) qrCodeImageWithContent:(NSString *) content headImageName:(NSString *) headImageName;


/**
 生成带有前景色以及后景色带头像的二维码

 @param content 传入生成二维码的内容
 @param foregroundColor 前背景色
 @param backgroundColor 后背景色
 @param headImageName  中间头像图片名称
 @return 返回二维码图片
 */
+(UIImage *) qrCodeImageWithContent:(NSString *)content foregroundColor:(UIColor *) foregroundColor BackgroundColor:(UIColor *) backgroundColor headImageName:(NSString *) headImageName;


/**
 修饰二维码图片(带有前后景色不带头像的二维码)

 @param qrCodeImageName 二维码名称
 @param foregroundColor 前背景色
 @param backgroundColor 后背景色
 @return 返回修饰后的二维码图片
 */
+(UIImage *) qrCodeImageWithQRCodeImage:(NSString *) qrCodeImageName  foregroundColor:(UIColor *) foregroundColor  andBackgroundColor:(UIColor *) backgroundColor;


/**
 修饰二维码图片(只带头像的二维码)

 @param qrCodeImageName 二维码名称
 @param headImageName 中间头像图片名称
 @return 返回修饰后的二维码图片
 */
+(UIImage *) qrCodeImageWithQRCodeImage:(NSString *) qrCodeImageName  headImageName:(NSString *) headImageName;

/**
 修饰二维码图片(带有前后景色带头像的二维码)

 @param qrCodeImageName 二维码名称
 @param foregroundColor 前背景色
 @param backgroundColor 后背景色
 @param headImageName 中间头像图片名称
 @return
 */
+(UIImage *) qrCodeImageWithQRCodeImage:(NSString *) qrCodeImageName  foregroundColor:(UIColor *) foregroundColor  andBackgroundColor:(UIColor *) backgroundColor headImageName:(NSString *) headImageName;

/**
 传入图片类型

 @param qRCodeImage 二维码图片
 @return 字符串
 */
+(NSString *) stringWithQRCodeImage:(UIImage *) qRCodeImage;

/**
根据二维码返回里面的数据 --传入图片名称

 @param qRCodeImageName 图片名称
 @return 字符串
 */
+(NSString *) stringWithQRCodeImageName:(NSString *) qRCodeImageName;

@end
