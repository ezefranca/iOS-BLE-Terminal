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
#import "BLE.h"

@implementation AppDelegate
{
	@private
	
	UIWindow* _mainWindow;
	JMTerminalViewController* _terminalViewController;
	BLE* _bleManager;
}
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	_bleManager = [[BLE alloc]init];
	JMTerminalViewModel* terminalViewModel = [[JMTerminalViewModel alloc]initWithBLEManager:_bleManager];
	_terminalViewController = [[JMTerminalViewController alloc]initWithViewModel:terminalViewModel];
	
	UINavigationController* navigationController = [[UINavigationController alloc]initWithRootViewController:_terminalViewController];

	_mainWindow = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
	_mainWindow.rootViewController = navigationController;
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
