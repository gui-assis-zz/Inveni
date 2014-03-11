//
//  NotificacaoViewController.m
//  Inveni
//
//  Created by Guilherme Augusto on 31/10/13.
//  Copyright (c) 2013 Primus Tech. All rights reserved.
//

#import "NotificacaoViewController.h"
#import "NotificationCell.h"

@interface NotificacaoViewController ()

@end

@implementation NotificacaoViewController

@synthesize tabela;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [tabela registerClass:[NotificationCell class] forCellWithReuseIdentifier:@"NotificationCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showMenuClick:(id)sender {
    [self.frostedViewController presentMenuViewController];
}

#pragma mark - CollectionViewDelegate 

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NotificationCell *cell = [[NotificationCell alloc] init];
    
    return cell;
}

@end
