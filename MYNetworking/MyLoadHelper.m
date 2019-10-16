//
//  MyLoadHelper.m
//  iSUP
//
//  Created by apple on 2019/1/18.
//  Copyright © 2019年 ZY. All rights reserved.
//

#import "MyLoadHelper.h"

@implementation MyLoadHelper

+(void)loadHelperPostUrl:(NSString *)urlStr withDictionary:(NSDictionary *)dic andSuccess:(SuccessLoadDataBlock)success andFailure:(FailureLoadDataBlock)failure{
    /* 创建网络请求对象 */
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    /* 设置请求和接收的数据编码格式 */
    manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 设置请求数据为 JSON 数据;
    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // 设置接收数据为 JSON 数据
    //设置请求头
    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager POST:urlStr parameters:dic headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary * errDic = [NSDictionary dictionaryWithObject:error forKey:@"error"];
        failure(errDic);
    }];
}

+(void)loadHelperFromDataUrl:(NSString *)urlStr andImageArray:(UIImage *)img withDictionary:(NSDictionary *)dic andSuccess:(SuccessLoadDataBlock)success andFailure:(FailureLoadDataBlock)failure{
    //配置AF
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    [manage.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString * imgName = dic[@"image"];
    NSString * imgN = [NSString stringWithFormat:@"%@.png",imgName];
    NSString * imgPath = dic[@"dir"];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:imgPath forKey:@"dir"];
    
    [manage POST:urlStr parameters:nil headers:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData * data = UIImageJPEGRepresentation(img, 0.9);
//        GLog(@"%f",(CGFloat)data.length);
        [formData appendPartWithFileData: data name:@"file" fileName:imgN mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        GLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString * receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//        GLog(@"%@",receiveStr);
        NSMutableDictionary * mdic = [[NSMutableDictionary alloc]init];
        if ([receiveStr isEqualToString:@"上传成功\r\n"]) {
            [mdic setObject:[NSNumber numberWithInteger:0] forKey:@"__result"];
        }else{
            [mdic setObject:[NSNumber numberWithInteger:-1] forKey:@"__result"];
        }
        success(mdic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary * errDic = [NSDictionary dictionaryWithObject:error forKey:@"error"];
        failure(errDic);
    }];
}

@end
