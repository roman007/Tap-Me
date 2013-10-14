//
//  ViewController.m
//  Tap Me
//
//  Created by Rodney on 10/11/13.
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(AVAudioPlayer *)setupAudioPlayerWithFile:(NSString *)file type:(NSString*)type {
    
    //1
    NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:type];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    //2
    NSError *error;
    
    //3
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    //4
    if (!audioPlayer) {
        NSLog(@"%@", [error description]);
    }
    
    //5
    return audioPlayer;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"bg_tile.png"]];
    
    scoreLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"field_score.png"]];
    timerLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"field_time.png"]];
                                 
    
    backgroundMusic = [self setupAudioPlayerWithFile:@"HallOfTheMountainKing" type:@"mp3"];
    buttonBeep = [self setupAudioPlayerWithFile:@"ButtonTap" type:@"wav"];
    secondBeep = [self setupAudioPlayerWithFile:@"SecondBeep" type:@"wav"];
    
    [self setupGame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)buttonPressed
{
    count++;
    
    scoreLabel.text = [NSString stringWithFormat: @"Score \n %i", count];
    
    [buttonBeep play];
  }    

-(void) setupGame
{
        
    // Set the initial setting
        
    seconds = 30;
    count = 0;
        
    // Set the labels
        
        timerLabel.text = [NSString stringWithFormat: @"Time: %i", seconds];
        scoreLabel.text = [NSString stringWithFormat: @"Score: %i", count];
    
        
    // Set the timer
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target: self selector:@selector(subtractTime) userInfo: nil repeats: YES];
    
    
    [backgroundMusic setVolume:0.3];
    [backgroundMusic play];
    
}

-(void)subtractTime
{
        seconds--;
        timerLabel.text =[NSString stringWithFormat: @"Timer: %i", seconds];
                          
    if (seconds == 0) {
        [timer invalidate];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Time is up!" message: [NSString stringWithFormat:@"You scored %i points", count] delegate:self cancelButtonTitle:@"Play Again" otherButtonTitles: nil];
        
        [alert show];
    }
    
    [secondBeep play];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self setupGame];
}
    
@end
