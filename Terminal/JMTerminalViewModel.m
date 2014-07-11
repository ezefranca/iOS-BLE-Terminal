//	The MIT License (MIT)
//
//	Copyright (c) 2014 Jens Meder
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//	SOFTWARE.

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
