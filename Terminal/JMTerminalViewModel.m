//
//  JMTerminalViewModel.m
//  Terminal
//
//  Created by Jens Meder on 09.07.14.
//  Copyright (c) 2014 Jens Meder. All rights reserved.
//

#import "JMTerminalViewModel.h"
#import "BLE.h"

@interface JMTerminalViewModel ()<BLEDelegate>

@end

@implementation JMTerminalViewModel
{
	@private
	
	BLE* _bleManager;
}

-(instancetype)initWithBLEManager:(BLE *)manager
{
	self = [super init];

	if (self)
	{
		_receivedText = @"";
		_bleManager = manager;
		[_bleManager controlSetup];
		_bleManager.delegate = self;
	}

	return self;
}

-(void)sendMessage:(NSString *)message
{
	NSData* data = [message dataUsingEncoding:NSASCIIStringEncoding];
	
	[_bleManager write:data];
}

-(void) connectionTimer:(NSTimer *)timer
{
    if(_bleManager.peripherals.count > 0)
    {
        [_bleManager connectPeripheral:[_bleManager.peripherals firstObject]];
    }
}

- (void) connect
{
    if (_bleManager.activePeripheral)
	{
        if(_bleManager.activePeripheral.state == CBPeripheralStateConnected)
        {
            [[_bleManager CM] cancelPeripheralConnection:[_bleManager activePeripheral]];
            return;
        }
    }
	
    if (_bleManager.peripherals)
	{
        _bleManager.peripherals = nil;
	}
    
    [_bleManager findBLEPeripherals:3];
    
    [NSTimer scheduledTimerWithTimeInterval:(float)3.0 target:self selector:@selector(connectionTimer:) userInfo:nil repeats:NO];
}

#pragma mark - Delegate

-(void) bleDidReceiveData:(unsigned char *)bytes length:(int)length
{
    NSData* data = [NSData dataWithBytes:bytes length:length];
	NSString* text = [[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];
	
	[self willChangeValueForKey:@"receivedText"];
	
	_receivedText = [_receivedText stringByAppendingFormat:@"%@\n",text];
	
	[self didChangeValueForKey:@"receivedText"];
}

-(void)bleDidConnect
{
}

-(void)bleDidDisconnect
{
}

NSTimer *rssiTimer;

-(void) readRSSITimer:(NSTimer *)timer
{
    [_bleManager readRSSI];
}

@end
