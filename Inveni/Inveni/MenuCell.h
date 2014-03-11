//
//  MenuCell.h
//  Inveni
//
//  Created by Guilherme Augusto on 04/11/13.
//  Copyright (c) 2013 Primus Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TipoEstabelecimento.h"

@interface MenuCell : UITableViewCell

@property (strong, nonatomic) TipoEstabelecimento *tipoEstabelecimento;
@property (weak, nonatomic) IBOutlet UILabel *tipo;
@property (weak, nonatomic) IBOutlet UIImageView *imgTipo;

@end