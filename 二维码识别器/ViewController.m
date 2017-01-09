//
//  ViewController.m
//  12--二维码识别器
//
//  Created by HQL on 16/6/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+QRCode.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //生成二维码图片
//   UIImage * qrCodeImage = [UIImage qrCodeImageWithContent:@"鸡爷uuuuuu泼妖"];
//    self.imageView.image = qrCodeImage;
//     UIImage * image =[UIImage imageNamed:@"鸡爷泼妖"];
//    NSString * string = [UIImage stringWithQRCodeImage:image];
//    NSString * string = [UIImage stringWithQRCodeImageName:@"鸡爷泼妖"];
//    NSLog(@"%@",string);
//   self.imageView.image =  [UIImage qrCodeImageWithContent:@"hhhhjjsnnn" headImageName:@"鸡爷泼妖"];
    self.imageView.image = [UIImage qrCodeImageWithContent:@"shdnsdcbsdbcsdnbc"];

}

-(void) test
{
//创建二维码识别器
    CIDetector * detector =[CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:nil];
    //生成图片
    UIImage * qrCodeImsgr =[UIImage imageNamed:@"鸡爷泼妖"];
    self.imageView.image = qrCodeImsgr;
    CIImage * ciImage =[CIImage imageWithCGImage:[qrCodeImsgr CGImage]];
   NSArray * features =  [detector featuresInImage:ciImage ];
    CIQRCodeFeature * feature =[features lastObject];
    NSLog(@"%@",feature.messageString);
}


@end
