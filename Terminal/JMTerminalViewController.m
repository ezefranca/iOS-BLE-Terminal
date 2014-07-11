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

#import "JMTerminalViewController.h"
#import "JMTerminalView.h"
#import "JMTerminalViewModel.h"

@interface JMTerminalViewController () <UITextFieldDelegate>

@end

@implementation JMTerminalViewController
{
	@private
	
	JMTerminalViewModel* _viewModel;
	UIBarButtonItem* _connectBarButtonItem;
}

-(instancetype)initWithViewModel:(JMTerminalViewModel *)viewModel
{
	self = [super init];
	
	if (self)
	{
		_viewModel = viewModel;
	}
	
	return self;
}

-(void)loadView
{
	self.view = [[JMTerminalView alloc]init];
}

-(void)viewDidLoad
{
	[super viewDidLoad];
	
	_connectBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Connect" style:UIBarButtonItemStylePlain target:_viewModel action:@selector(connect)];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	self.navigationItem.rightBarButtonItem = _connectBarButtonItem;
	
	JMTerminalView* terminalView = (JMTerminalView*)self.view;
	
	terminalView.inputTextField.delegate = self;
	
	[_viewModel addObserver:self forKeyPath:@"receivedText" options:NSKeyValueObservingOptionNew context:NULL];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	JMTerminalView* terminalView = (JMTerminalView*)self.view;
	
	terminalView.inputTextField.delegate = nil;
	
	[_viewModel removeObserver:self forKeyPath:@"receivedText"];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void) keyboardFrameWillChange:(NSNotification*)notification
{
	UIViewAnimationCurve curve = [((NSNumber*)[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey]) integerValue];
	float duration = [((NSNumber*)[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey]) floatValue];
	CGRect endFrame = [((NSValue*)[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]) CGRectValue];
	
	[UIView beginAnimations:@"" context:NULL];
	[UIView setAnimationCurve:curve];
	[UIView setAnimationDuration:duration];
	
	CGRect frame = self.view.frame;
	
	self.view.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, endFrame.origin.y);
	[self.view layoutIfNeeded];
	[UIView commitAnimations];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	JMTerminalView* terminalView = (JMTerminalView*)self.view;
	
	terminalView.receivingTextView.text = _viewModel.receivedText;
}

#pragma mark - Text field delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[_viewModel sendMessage:textField.text];
	textField.text = nil;

	return NO;
}

@end
