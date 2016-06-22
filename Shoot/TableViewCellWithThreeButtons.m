//
//  TableViewCellWithThreeButtons.m
//  Shoot
//
//  Created by Thomas Mac on 12/06/2016.
//  Copyright © 2016 Thomas Mac. All rights reserved.
//

#import "TableViewCellWithThreeButtons.h"
#import "GameViewController.h"
#import "LevelTableViewController.h"

@interface TableViewCellWithThreeButtons()

@property(nonatomic,strong) UIButton *firstButton;
@property(nonatomic,strong) UIButton *secondButton;
@property(nonatomic,strong) UIButton *thirdButton;

@end

@implementation TableViewCellWithThreeButtons

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat decalage = 10.0;
    
    float width = (self.frame.size.width - 5 * decalage) / 4;
    
    self.thirdButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - decalage - width, 0.0, width, self.frame.size.height)];
    
    self.thirdButton.imageView.frame = CGRectMake(0, 0, self.thirdButton.frame.size.width, self.thirdButton.frame.size.height);
    
    [self.thirdButton addTarget:self action:@selector(thirdButtonActionListener) forControlEvents:UIControlEventTouchUpInside];
    
    [self.thirdButton setImage:[UIImage imageNamed:@"etoile3.png"] forState:UIControlStateNormal];
    
    self.secondButton = [[UIButton alloc] initWithFrame:CGRectMake(self.thirdButton.frame.origin.x - decalage - self.thirdButton.frame.size.width, 0.0, self.thirdButton.frame.size.width, self.thirdButton.frame.size.height)];
    
    self.secondButton.imageView.frame = CGRectMake(0, 0, self.secondButton.frame.size.width, self.secondButton.frame.size.height);
    
    [self.secondButton addTarget:self action:@selector(secondButtonActionListener) forControlEvents:UIControlEventTouchUpInside];
    
    [self.secondButton setImage:[UIImage imageNamed:@"etoile2.png"] forState:UIControlStateNormal];
    
    self.firstButton = [[UIButton alloc] initWithFrame:CGRectMake(self.secondButton.frame.origin.x - decalage - self.secondButton.frame.size.width, 0.0, self.secondButton.frame.size.width, self.secondButton.frame.size.height)];
    
    self.firstButton.imageView.frame = CGRectMake(0, 0, self.firstButton.frame.size.width, self.firstButton.frame.size.height);
    
    [self.firstButton addTarget:self action:@selector(firstButtonActionListener) forControlEvents:UIControlEventTouchUpInside];
    
    [self.firstButton setImage:[UIImage imageNamed:@"etoile1.png"] forState:UIControlStateNormal];
    
    self.textLabel.frame = CGRectMake(decalage, 0.0, self.firstButton.frame.size.width, self.frame.size.height);
    
    self.imageView.hidden = YES;
    
    self.layer.borderColor = [UIColor colorWithRed:213.0/255.0 green:210.0/255.0 blue:199.0/255.0 alpha:1.0].CGColor;
    
    self.layer.borderWidth = 2.5;
    self.layer.cornerRadius = 7.5;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowRadius = 8.0;
    self.layer.shadowOpacity = 0.8;
    self.layer.masksToBounds = false;
    
    [self setButtonsHidden:YES];
    
    [self addSubview:self.firstButton];
    [self addSubview:self.secondButton];
    [self addSubview:self.thirdButton];
    
    [(LevelTableViewController*)self.levelTableViewController setButtonsImage:self withIndice:self.indice];
    
    [(LevelTableViewController*)self.levelTableViewController setButtonsHidden:self withIndice:self.indice];
}

- (void) firstButtonActionListener
{
    self.difficulte = 1;
    [(LevelTableViewController*)self.levelTableViewController launchGame:self];
}

- (void) secondButtonActionListener
{
    self.difficulte = 2;
    [(LevelTableViewController*)self.levelTableViewController launchGame:self];
}

- (void) thirdButtonActionListener
{
    self.difficulte = 3;
    [(LevelTableViewController*)self.levelTableViewController launchGame:self];
}

- (void) setFirstButtonImage
{
    [self.firstButton setImage:[UIImage imageNamed:@"1etoile.png"] forState:UIControlStateNormal];
}

- (void) setSecondButtonImage
{
    [self.secondButton setImage:[UIImage imageNamed:@"2etoile.png"] forState:UIControlStateNormal];
}

- (void) setThirdButtonImage
{
    [self.thirdButton setImage:[UIImage imageNamed:@"3etoile.png"] forState:UIControlStateNormal];
}

- (void) setButtonsHidden:(BOOL)hidden
{
    self.firstButton.hidden = hidden;
    self.secondButton.hidden = hidden;
    self.thirdButton.hidden = hidden;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
