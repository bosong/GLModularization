//
//  ModuleProtocols.h
//  UnitsDemo
//
//  Created by guanglong on 2017/5/26.
//  Copyright © 2017年 bjhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModuleProtocols <NSObject>

@optional
- (void)proto_setModuleParams:(NSDictionary*)params;

@end


@protocol MapModuleProtocol <ModuleProtocols>
@end


@protocol ChatModuleProtocol <ModuleProtocols>
@end
