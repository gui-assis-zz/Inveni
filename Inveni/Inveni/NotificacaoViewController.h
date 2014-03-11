//
//  NotificacaoViewController.h
//  Inveni
//
//  Created by Guilherme Augusto on 31/10/13.
//  Copyright (c) 2013 Primus Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface NotificacaoViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *tabela;

- (IBAction)showMenuClick:(id)sender;

@end
