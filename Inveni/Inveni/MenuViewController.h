//
//  MenuViewController.h
//  Inveni
//
//  Created by Guilherme Augusto on 01/11/13.
//  Copyright (c) 2013 Primus Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuCell.h"
#import "TipoEstabelecimento.h"
#import "REFrostedViewController.h"

@protocol MenuViewControllerDelegate <NSObject>

-(void) onClicouTipo;

@end

@interface MenuViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    id <MenuViewControllerDelegate> delegate;
}

@property (weak, nonatomic) IBOutlet UITableView *tabela;
@property (nonatomic) id delegate;

@end
