//
//  LevelTableViewController.m
//  Shoot
//
//  Created by Thomas Mac on 12/06/2016.
//  Copyright © 2016 Thomas Mac. All rights reserved.
//

#import "LevelTableViewController.h"
#import "GameViewController.h"

@interface LevelTableViewController ()

@property(nonatomic, strong) NSUserDefaults *sauvegarde;

@end

@implementation LevelTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    
    [self.tableView registerClass:[TableViewCellWithThreeButtons class] forCellReuseIdentifier:@"cell"];
    
    self.sauvegarde = [NSUserDefaults standardUserDefaults];
    
    [self.navigationItem setTitle:[NSString stringWithFormat:@"Menu principal : %d étoiles / 30",[self getNombreEtoiles]]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) sauvegarder:(int)level difficulte:(int)difficulte
{
    [self.sauvegarde setBool:YES forKey:[NSString stringWithFormat:@"level%d%d", level - 1, difficulte - 1]];
    [self.sauvegarde synchronize];
    self.navigationController.navigationBar.hidden = NO;
    [self.tableView reloadData];
}

- (int) getNombreEtoiles
{
    int resultat = 0;
    for (int i=0;i<5;i++)
    {
        for (int j=0;j<3;j++)
        {
            if ([self.sauvegarde boolForKey:[NSString stringWithFormat:@"level%d%d",i,j]])
            {
                resultat += j + 1;
            }
        }
    }
    return resultat;
}

- (void) setButtonsHidden:(TableViewCellWithThreeButtons*)cell withIndice:(int)indice
{
    int nombreEtoiles = [self getNombreEtoiles];
    if (indice == 0 || (indice == 1 && nombreEtoiles >= 3) || (indice == 2 && nombreEtoiles >= 8) || (indice == 3 && nombreEtoiles >= 14) || (indice == 4 && nombreEtoiles >= 24))
    {
        [cell setButtonsHidden:NO];
    }
}

- (void) setButtonsImage:(TableViewCellWithThreeButtons*)cell withIndice:(int)indice
{
    if ([self.sauvegarde boolForKey:[NSString stringWithFormat:@"level%d0", indice]])
    {
        [cell setFirstButtonImage];
    }
    if ([self.sauvegarde boolForKey:[NSString stringWithFormat:@"level%d1", indice]])
    {
        [cell setSecondButtonImage];
    }
    if ([self.sauvegarde boolForKey:[NSString stringWithFormat:@"level%d2", indice]])
    {
        [cell setThirdButtonImage];
    }
}

- (int) getNumberLevel
{
    int nombreEtoiles = [self getNombreEtoiles];
    if (nombreEtoiles >= 24)
    {
        return 5;
    }
    else if (nombreEtoiles >= 14)
    {
        return 4;
    }
    else if (nombreEtoiles >= 8)
    {
        return 3;
    }
    else if (nombreEtoiles >= 3)
    {
        return 2;
    }
    return 1;
}

- (void) launchGame:(TableViewCellWithThreeButtons*)cell
{
    GameViewController *gameViewController = [[GameViewController alloc] init];
    
    gameViewController.level = cell.level;
    gameViewController.difficulte = cell.difficulte;
    gameViewController.levelTableViewController = self;
    
    [self.navigationController pushViewController:gameViewController animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self getNumberLevel];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCellWithThreeButtons *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Level %d",(int)(indexPath.row + 1)];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.levelTableViewController = self;
    
    cell.indice = (int)indexPath.row;
    cell.level = cell.indice + 1;
    
    return cell;
}

@end
