//
//  JMTerminalViewModel.h
//  Terminal
//
//  Created by Jens Meder on 09.07.14.
//  Copyright (c) 2014 Jens Meder. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BLE;

@interface JMTerminalViewModel : NSObject

@property (nonatomic, strong, readonly) NSString* receivedText;

-(instancetype)initWithBLEManager:(BLE*)manager;

-(void) sendMessage:(NSString*)message;
-(void) connect;

@end
