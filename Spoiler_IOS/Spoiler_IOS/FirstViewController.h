//
//  FirstViewController.h
//  Spoiler_IOS
//
//  Created by Tausif Ahmed on 9/16/14.
//  Copyright (c) 2014 Spoiler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController

//@property (nonatomic, retain) IBOutlet UIButton *RunBtn;
//@property (nonatomic, retain) IBOutlet UIButton *StopBtn;
@property (weak, nonatomic) IBOutlet UIButton *RunBtn;
@property (weak, nonatomic) IBOutlet UIButton *StopBtn;

@end
