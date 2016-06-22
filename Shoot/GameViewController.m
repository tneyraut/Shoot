//
//  GameViewController.m
//  Shoot
//
//  Created by Thomas Mac on 14/06/2016.
//  Copyright © 2016 Thomas Mac. All rights reserved.
//

#import "GameViewController.h"
#import <AudioToolbox/AudioServices.h>
#import "Ennemi.h"

@interface GameViewController ()

@property(nonatomic, strong) NSMutableArray *coeursArray;

@property(nonatomic) int pv;

@property(nonatomic) int munition;

@property(nonatomic, strong) UILabel *rechargerLabel;

@property(nonatomic, strong) UIButton *reloadButton;

@property(nonatomic, strong) NSMutableArray *munitionsArray;

@property(nonatomic, strong) NSMutableArray *ennemisArray;

@property(nonatomic) int ennemisKilled;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.pv = 8;
    self.munition = 5;
    
    self.ennemisKilled = 0;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fond.png"]];
    
    [self initCoeursArray];
    
    self.rechargerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, (self.view.frame.size.height - 30) / 2, self.view.frame.size.width, 30.0)];
    self.rechargerLabel.textColor = [UIColor redColor];
    self.rechargerLabel.textAlignment = NSTextAlignmentCenter;
    self.rechargerLabel.font = [UIFont fontWithName:@"Arial" size:30.0];
    self.rechargerLabel.text = @"RECHARGER !";
    self.rechargerLabel.hidden = YES;
    [self.view addSubview:self.rechargerLabel];
    
    self.reloadButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 60.0, self.view.frame.size.height - 60.0, 50.0, 50.0)];
    [self.reloadButton setImage:[UIImage imageNamed:@"reload.png"] forState:UIControlStateNormal];
    [self.reloadButton addTarget:self action:@selector(reloadButtonActionListener) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.reloadButton];
    
    [self initMunitionsArray];
    
    [self initEnnemisArray];
    
    [self setEnnemis];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initCoeursArray
{
    self.coeursArray = [[NSMutableArray alloc] init];
    for (int i=0;i<self.pv;i++)
    {
        [self.coeursArray addObject:[[UIImageView alloc] init]];
    }
    
    UIImageView *imageViewOne = self.coeursArray[0];
    [imageViewOne setFrame:CGRectMake(0, 0, self.view.frame.size.width / self.coeursArray.count, self.view.frame.size.width / self.coeursArray.count)];
    [imageViewOne setImage:[UIImage imageNamed:@"coeur.png"]];
    [imageViewOne setHidden:NO];
    [self.view addSubview:imageViewOne];
    for (int i=1;i<self.coeursArray.count;i++)
    {
        UIImageView *imageView = self.coeursArray[i];
        UIImageView *otherImageView = self.coeursArray[i - 1];
        [imageView setFrame:CGRectMake(otherImageView.frame.origin.x + otherImageView.frame.size.width, 0, imageViewOne.frame.size.width, imageViewOne.frame.size.height)];
        [imageView setImage:[UIImage imageNamed:@"coeur.png"]];
        [imageView setHidden:NO];
        [self.view addSubview:imageView];
    }
}

- (void) initMunitionsArray
{
    self.munitionsArray = [[NSMutableArray alloc] init];
    for (int i=0;i<self.munition;i++)
    {
        [self.munitionsArray addObject:[[UIImageView alloc] init]];
    }
    
    UIImageView *imageViewOne = self.munitionsArray[0];
    [imageViewOne setFrame:CGRectMake(self.reloadButton.frame.origin.x - 20.0, self.reloadButton.frame.origin.y, 10.0, self.reloadButton.frame.size.height)];
    [imageViewOne setImage:[UIImage imageNamed:@"ammo.png"]];
    [imageViewOne setHidden:NO];
    [self.view addSubview:imageViewOne];
    for (int i=1;i<self.munitionsArray.count;i++)
    {
        UIImageView *imageView = self.munitionsArray[i];
        UIImageView *otherImageView = self.munitionsArray[i - 1];
        [imageView setFrame:CGRectMake(otherImageView.frame.origin.x - imageViewOne.frame.size.width - 10.0, imageViewOne.frame.origin.y, imageViewOne.frame.size.width, imageViewOne.frame.size.height)];
        [imageView setImage:[UIImage imageNamed:@"ammo.png"]];
        [imageView setHidden:NO];
        [self.view addSubview:imageView];
    }
}

- (void) initEnnemisArray
{
    int nombreMaxEnnemis = [self getNombreMaxEnnemis];
    int rapidite = [self getRapiditeEnnemi];
    
    self.ennemisArray = [[NSMutableArray alloc] init];
    for (int i=0;i<nombreMaxEnnemis;i++)
    {
        Ennemi *ennemi = [[Ennemi alloc] init];
        [ennemi initInstanceInViewController:self rapidite:rapidite];
        [self.ennemisArray addObject:ennemi];
    }
}

- (void) setEnnemis
{
    int nombreMaxEnnemis = [self getNombreMaxEnnemis];
    int nombreMinEnnemis = [self getNombreMinEnnemis];
    
    int nombreEnnemis = arc4random_uniform(nombreMaxEnnemis) + 1;
    while (nombreEnnemis < nombreMinEnnemis)
    {
        nombreEnnemis = arc4random_uniform(nombreMaxEnnemis) + 1;
    }
    for (int i=0;i<nombreEnnemis;i++)
    {
        UIImageView *coeur = self.coeursArray[0];
        
        Ennemi *ennemi = self.ennemisArray[i];
        
        [ennemi setFrameWithLimiteHaut:(coeur.frame.origin.y + coeur.frame.size.height) limiteBas:self.reloadButton.frame.origin.y];
    }
}

- (void) feu
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    self.pv--;
    for (int i=(int)self.coeursArray.count-1;i>=0;i--)
    {
        UIImageView *imageView = self.coeursArray[i];
        if (!imageView.hidden)
        {
            imageView.hidden = YES;
            break;
        }
    }
    if (self.pv <= 0)
    {
        for (int i=0;i<self.ennemisArray.count;i++)
        {
            Ennemi *ennemi = self.ennemisArray[i];
            [ennemi stopTimer];
        }
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Défaite" message:@"Vous avez été tué !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (void) reloadButtonActionListener
{
    self.munition = 5;
    self.rechargerLabel.hidden = YES;
    for (int i=0;i<self.munitionsArray.count;i++)
    {
        UIImageView *imageView = self.munitionsArray[i];
        [imageView setHidden:NO];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.munition <= 0)
    {
        return;
    }
    self.munition--;
    if (self.munition <= 0)
    {
        [self.rechargerLabel setHidden:NO];
    }
    for (int i=(int)self.munitionsArray.count-1;i>=0;i--)
    {
        UIImageView *imageView = self.munitionsArray[i];
        if (!imageView.hidden)
        {
            imageView.hidden = YES;
            break;
        }
    }
    
    UITouch *myTouch = [[touches allObjects] objectAtIndex: 0];
    CGPoint currentPos = [myTouch locationInView:nil];
    
    for (int i=0;i<self.ennemisArray.count;i++)
    {
        Ennemi *ennemi = self.ennemisArray[i];
        if (![ennemi isHidden] && currentPos.x >= [ennemi getX] && currentPos.x <= [ennemi getX] + [ennemi getWidth] && currentPos.y >= [ennemi getY] && currentPos.y <= [ennemi getY] + [ennemi getHeigth])
        {
            [ennemi setHidden];
            self.ennemisKilled++;
        }
    }
    if (self.ennemisKilled == [self getObjectifCible]) //&& [self getEnnemisRestants] == 0)
    {
        for (int i=0;i<self.ennemisArray.count;i++)
        {
            Ennemi *ennemi = self.ennemisArray[i];
            [ennemi stopTimer];
        }
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Victoire" message:@"Vous avez gagné !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else if ([self getEnnemisRestants] == 0)// && self.ennemisKilled < [self getObjectifCible])
    {
        [self setEnnemis];
    }
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:@"Victoire"])
    {
        [self.levelTableViewController sauvegarder:self.level difficulte:self.difficulte];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (int) getObjectifCible
{
    if (self.level == 1) {
        if (self.difficulte == 1)
            return 20;
        else if (self.difficulte == 2)
            return 25;
        else if (self.difficulte == 3)
            return 30;
    }
    else if (self.level == 2) {
        if (self.difficulte == 1)
            return 30;
        else if (self.difficulte == 2)
            return 35;
        else if (self.difficulte == 3)
            return 40;
    }
    else if (self.level == 3) {
        if (self.difficulte == 1)
            return 35;
        else if (self.difficulte == 2)
            return 45;
        else if (self.difficulte == 3)
            return 50;
    }
    else if (self.level == 4) {
        if (self.difficulte == 1)
            return 35;
        else if (self.difficulte == 2)
            return 45;
        else if (self.difficulte == 3)
            return 50;
    }
    else if (self.level == 5) {
        if (self.difficulte == 1)
            return 45;
        else if (self.difficulte == 2)
            return 50;
        else if (self.difficulte == 3)
            return 60;
    }
    return 0;
}

- (int) getNombreMaxEnnemis
{
    if (self.level == 1) {
        if (self.difficulte == 1)
            return 3;
        else
            return 4;
    }
    else if (self.level == 2) {
        if (self.difficulte == 1)
            return 4;
    }
    return 5;
}

- (int) getNombreMinEnnemis
{
    if (self.level == 1) {
        if (self.difficulte == 1)
            return 2;
        else
            return 3;
    }
    else if (self.level == 2) {
        if (self.difficulte == 1)
            return 3;
        else
            return 4;
    }
    else if (self.level == 3)
    {
        if (self.difficulte == 1)
            return 3;
        else
            return 4;
    }
    else if (self.level == 4)
    {
        return 4;
    }
    return 5;
}

- (float) getRapiditeEnnemi
{
    if (self.level == 1) {
        if (self.difficulte == 1)
            return 3.0;
        else if (self.difficulte == 2)
            return 3.0;
        else if (self.difficulte == 3)
            return 2.5;
    }
    else if (self.level == 2) {
        if (self.difficulte == 1)
            return 2.5;
        else if (self.difficulte == 2)
            return 2.0;
        else if (self.difficulte == 3)
            return 1.5;
    }
    else if (self.level == 3) {
        if (self.difficulte == 1)
            return 1.5;
        else if (self.difficulte == 2)
            return 1.5;
        else if (self.difficulte == 3)
            return 1.5;
    }
    else if (self.level == 4) {
        if (self.difficulte == 1)
            return 1.0;
        else if (self.difficulte == 2)
            return 1.0;
        else if (self.difficulte == 3)
            return 1.0;
    }
    else if (self.level == 5) {
        if (self.difficulte == 1)
            return 2.0;
        else if (self.difficulte == 2)
            return 1.5;
        else if (self.difficulte == 3)
            return 1.0;
    }
    return 0.0;
}

- (int) getEnnemisRestants
{
    int resultat = 0;
    for (int i=0;i<self.ennemisArray.count;i++)
    {
        Ennemi *ennemi = self.ennemisArray[i];
        if (![ennemi isHidden])
        {
            resultat++;
        }
    }
    return resultat;
}

@end
