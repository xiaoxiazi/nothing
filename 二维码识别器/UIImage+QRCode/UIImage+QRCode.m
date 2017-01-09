//
//  UIImage+QRCode.m
//  11-生成二维码
//
//  Created by HQL on 16/6/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "UIImage+QRCode.h"

@implementation UIImage (QRCode)

#pragma mark 识别图片中的二维码
///根据二维码返回里面的数据 --传入字符串类型
+(NSString *) stringWithQRCodeImage:(UIImage *) qRCodeImage
{
    //创建二维码识别器
    CIDetector * detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:nil];
    //将UIImage转为CIImage
    CIImage * ciImage = [CIImage imageWithCGImage:[qRCodeImage CGImage]];
    //判断如果image是一般的UIImage的话，就不为nil，否则为nil
    if (ciImage == nil) {
        ciImage = [qRCodeImage CIImage];
    }
    //取出里面的属性的特征
    NSArray * features = [detector featuresInImage:ciImage];
    CIQRCodeFeature * feature = [features lastObject];
    return feature.messageString;
}

///根据二维码返回里面的数据 --传入图片类型
+(NSString *) stringWithQRCodeImageName:(NSString *) qRCodeImageName
{
    //创建二维码识别器
    CIDetector * detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:nil];
    //将UIImage转为CIImage
    UIImage * image = [UIImage imageNamed:qRCodeImageName];
    CIImage * ciImage = [CIImage imageWithCGImage:[image CGImage]];
    //判断如果image是一般的UIImage的话，就不为nil，否则为nil
    if (ciImage == nil) {
        ciImage = [image CIImage];
    }
    //取出里面的属性的特征
    NSArray * features = [detector featuresInImage:ciImage];
    CIQRCodeFeature * feature = [features lastObject];
    return feature.messageString;

}

#pragma mark 传入二维码，对其进行修饰
///修饰二维码图片(只带头像的二维码)
+(UIImage *) qrCodeImageWithQRCodeImage:(NSString *) qrCodeImageName  headImageName:(NSString *) headImageName
{
    return [UIImage qrCodeImageWithQRCodeImage:qrCodeImageName Content:nil foregroundColor:nil BackgroundColor:nil headImageName:headImageName];
}

///修饰二维码图片(带有前后景色带头像的二维码)
+(UIImage *) qrCodeImageWithQRCodeImage:(NSString *) qrCodeImageName  foregroundColor:(UIColor *) foregroundColor  andBackgroundColor:(UIColor *) backgroundColor headImageName:(NSString *) headImageName
{
    return [UIImage qrCodeImageWithQRCodeImage:qrCodeImageName Content:nil foregroundColor:foregroundColor BackgroundColor:backgroundColor headImageName:headImageName];
}
///修饰二维码图片(带有前后景色的二维码)
+(UIImage *) qrCodeImageWithQRCodeImage:(NSString *) qrCodeImageName  foregroundColor:(UIColor *) foregroundColor  andBackgroundColor:(UIColor *) backgroundColor
{
    return [UIImage qrCodeImageWithQRCodeImage:qrCodeImageName Content:nil foregroundColor:foregroundColor BackgroundColor:backgroundColor headImageName:nil];
}

#pragma mark 传入文本，生成二维码
////根据内容生成二维码
+(UIImage *) qrCodeImageWithContent:(NSString *) content
{
    return [UIImage qrCodeImageWithContent:content foregroundColor:nil BackgroundColor:nil headImageName:nil];
}

///生成带有头像的二维码
+(UIImage *) qrCodeImageWithContent:(NSString *) content headImageName:(NSString *) headImageName
{
    return [UIImage qrCodeImageWithContent:content foregroundColor:nil BackgroundColor:nil headImageName:headImageName];
}

///生成带有前景色以及后景色不带头像的二维码
+(UIImage *) qrCodeImageWithContent:(NSString *)content foregroundColor:(UIColor *) foregroundColor  andBackgroundColor:(UIColor *) backgroundColor
{
    return  [UIImage qrCodeImageWithContent:content foregroundColor:foregroundColor BackgroundColor:backgroundColor headImageName:nil];
}

///生成带有前景色以及后景色带头像的二维码
+(UIImage *) qrCodeImageWithContent:(NSString *)content foregroundColor:(UIColor *) foregroundColor BackgroundColor:(UIColor *) backgroundColor headImageName:(NSString *) headImageName
{
    return [UIImage qrCodeImageWithQRCodeImage:nil Content:content foregroundColor:foregroundColor BackgroundColor:backgroundColor headImageName:headImageName];
}

///生成带有前景色以及后景色带头像的二维码
+(UIImage *) qrCodeImageWithQRCodeImage:(NSString *) qrCodeImageName  Content:(NSString *)content foregroundColor:(UIColor *) foregroundColor BackgroundColor:(UIColor *) backgroundColor headImageName:(NSString *) headImageName
{
    //创建二维码滤镜器
    CIFilter * filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    CIImage * ciImage = nil;
    //判断传入的是文本还是二维码
    if (content == nil)
    {
        ciImage = [CIImage imageWithCGImage:[[UIImage imageNamed:qrCodeImageName] CGImage]];
    }
    else
    {
        //准备数据
        NSData * data = [content dataUsingEncoding:NSUTF8StringEncoding];
        [filter setValue:data forKey:@"inputMessage"];
        //取出图片
        ciImage = filter.outputImage;
    }
    
    if (foregroundColor != nil && backgroundColor != nil)
    {
        //设置前景色以及后景色
        CIFilter * ciFalseFilter= [CIFilter filterWithName:@"CIFalseColor"];
        //赋值
        CIColor *ciForegroundColor  = [CIColor colorWithCGColor:[foregroundColor CGColor]];
        CIColor *ciBackgroundColor  = [CIColor colorWithCGColor:[backgroundColor CGColor]];
        [ciFalseFilter setValue:ciImage forKey:@"inputImage"];
        [ciFalseFilter setValue:ciForegroundColor forKey:@"inputColor0"];
        [ciFalseFilter setValue:ciBackgroundColor forKey:@"inputColor1"];
        //取出图片
        ciImage = ciFalseFilter.outputImage;
    }
    
    //放大图片
    ciImage = [ciImage imageByApplyingTransform:CGAffineTransformMakeScale(10, 10)];
    UIImage * qrImage = [UIImage imageWithCIImage:ciImage];
    //判断是否有头像图片
    if (headImageName != nil)
    {
        //在中央绘制图片
        //1.开启图片上下文
        UIGraphicsBeginImageContext(qrImage.size);
        //绘制图片
        [qrImage drawInRect:CGRectMake(0, 0, qrImage.size.width, qrImage.size.height)];
        //需要绘制的图片
        UIImage * headImage =[UIImage imageNamed:headImageName];
        CGFloat headX = qrImage.size.width * 0.4;
        CGFloat headY = qrImage.size.width * 0.4;
        CGFloat headW = qrImage.size.width * 0.2;
        CGFloat headH = qrImage.size.width * 0.2;
        [headImage drawInRect:CGRectMake(headX, headY, headW, headH)];
        //取出图片
        qrImage = UIGraphicsGetImageFromCurrentImageContext();
        //关闭图片上下文
        UIGraphicsEndImageContext();
    }
    return qrImage;
}
@end
