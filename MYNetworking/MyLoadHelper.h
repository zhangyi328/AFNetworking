//
//  MyLoadHelper.h
//  iSUP
//
//  Created by apple on 2019/1/18.
//  Copyright © 2019年 ZY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface MyLoadHelper : NSObject
//成功回调
typedef void(^SuccessLoadDataBlock)(NSDictionary * data);
//失败回调
typedef void(^FailureLoadDataBlock)(NSDictionary * data);

/**
 *  注释  post 方法
 *
 */
+(void)loadHelperPostUrl:(NSString *)urlStr withDictionary:(NSDictionary *)dic andSuccess:(SuccessLoadDataBlock)success andFailure:(FailureLoadDataBlock)failure;
/**
 *  注释  From 表单
 *
 */
+(void)loadHelperFromDataUrl:(NSString *)urlStr andImageArray:(UIImage *)img withDictionary:(NSDictionary *)dic andSuccess:(SuccessLoadDataBlock)success andFailure:(FailureLoadDataBlock)failure;
@end
