//
//  ViewController.h
//  Tap Me
//
//  Created by Rodney on 10/11/13.
//
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<UIAlertViewDelegate> {
  
  IBOutlet UILabel *timerLabel;
  IBOutlet UILabel *scoreLabel;  
  
    
    NSInteger count;
    NSInteger seconds;
    NSTimer *timer;
    
    AVAudioPlayer *buttonBeep;
    AVAudioPlayer *secondBeep;
    AVAudioPlayer *backgroundMusic;
    
}

- (IBAction)buttonPressed;


@end
