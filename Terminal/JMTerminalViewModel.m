//
//  JMTerminalViewModel.m
//  Terminal
//
//  Created by Jens Meder on 09.07.14.
//  Copyright (c) 2014 Jens Meder. All rights reserved.
//

#import "JMTerminalViewModel.h"

@interface JMTerminalViewModel ()

@end

@implementation JMTerminalViewModel
{
	@private
	

}

-(instancetype)initWithModem:(JMFSKModem *)modem
{
	self = [super init];

	if (self)
	{
		_receivedText = @"";
	}

	return self;
}

-(void)sendMessage:(NSString *)message
{
	NSData* data = [message dataUsingEncoding:NSASCIIStringEncoding];
	

}

#pragma mark - Delegate

-(void)modem:(JMFSKModem *)modem didReceiveData:(NSData *)data
{
	NSString* text = [[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];
	
	[self willChangeValueForKey:@"receivedText"];
	
	_receivedText = [_receivedText stringByAppendingFormat:@"%@\n",text];
	
	[self didChangeValueForKey:@"receivedText"];
}

@end
