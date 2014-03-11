//
//  ListaViewController.h
//  Inveni
//
//  Created by Guilherme Augusto on 31/10/13.
//  Copyright (c) 2013 Primus Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import "ListaCell.h"
#import "EstabelecimentoService.h"
#import "Estabelecimento.h"
#import "MenuViewController.h"

@interface ListaViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, ListaCellDelegate, REFrostedViewControllerDelegate, MenuViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *tabela;

- (IBAction)showMenuClick:(id)sender;

@end
