//
//  AppDelegate.m
//  Terminal
//
//  Created by Jens Meder on 09.07.14.
//  Copyright (c) 2014 Jens Meder. All rights reserved.
//

#import "AppDelegate.h"
#import "JMTerminalViewController.h"
#import "JMTerminalViewModel.h"

@implementation AppDelegate
{
	@private
	
	UIWindow* _mainWindow;
	JMTerminalViewController* _terminalViewController;
	JMFSKModem* _modem;
}
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	JMTerminalViewModel* terminalViewModel = [[JMTerminalViewModel alloc]init];
	_terminalViewController = [[JMTerminalViewController alloc]initWithViewModel:terminalViewModel];

	_mainWindow = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
	_mainWindow.rootViewController = _terminalViewController;
	[_mainWindow makeKeyAndVisible];
	
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	
}

-(void)applicationDidBecomeActive:(UIApplication *)application
{
	
}

@end
