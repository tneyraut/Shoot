//
//  Ennemi.m
//  Shoot
//
//  Created by Thomas Mac on 14/06/2016.
//  Copyright © 2016 Thomas Mac. All rights reserved.
//

#import "Ennemi.h"

@interface Ennemi()

@property(nonatomic, strong) NSTimer *timer;

@property(nonatomic, strong) UIImageView *imageView;

@property(nonatomic, strong) GameViewController *gameViewController;

@property(nonatomic) float rapidite;

@end

@implementation Ennemi

- (void) initInstanceInViewController:(GameViewController*)gameViewController rapidite:(float)rapidite
{
    self.gameViewController = gameViewController;
    self.rapidite = rapidite;
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 40.0, 60.0)];
    [self.imageView setImage:[UIImage imageNamed:@"cible.png"]];
    [self.imageView setHidden:YES];
    [self.gameViewController.view addSubview:self.imageView];
    
    self.timer = [[NSTimer alloc] init];
}

- (void) stopTimer
{
    [self.timer invalidate];
}

- (BOOL) isHidden
{
    return self.imageView.hidden;
}

- (void) setFrameWithLimiteHaut:(int)limiteHaut limiteBas:(int)limiteBas
{
    int x = arc4random_uniform(self.gameViewController.view.frame.size.width - self.imageView.frame.size.width);
    
    int y = arc4random_uniform(self.gameViewController.view.frame.size.height - self.imageView.frame.size.height - limiteHaut) + limiteHaut;
    
    if (y + self.imageView.frame.size.height >= limiteBas)
    {
        y = y - self.gameViewController.view.frame.size.height + limiteBas;
    }
    
    [self.imageView setFrame:CGRectMake(x, y, self.imageView.frame.size.width, self.imageView.frame.size.height)];
    self.imageView.hidden = NO;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.rapidite target:self.gameViewController selector:@selector(feu) userInfo:nil repeats:YES];
}

- (void) setHidden
{
    self.imageView.hidden = YES;
    [self.timer invalidate];
}

- (float) getX
{
    return self.imageView.frame.origin.x;
}

- (float) getY
{
    return self.imageView.frame.origin.y;
}

- (float) getWidth
{
    return self.imageView.frame.size.width;
}

- (float) getHeigth
{
    return self.imageView.frame.size.height;
}

@end
