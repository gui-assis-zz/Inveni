//
//  MenuCell.m
//  Inveni
//
//  Created by Guilherme Augusto on 04/11/13.
//  Copyright (c) 2013 Primus Tech. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell

@synthesize tipo, tipoEstabelecimento, imgTipo;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) prepareForReuse{
    if (tipoEstabelecimento.ativo) {
        tipo.textColor = [UIColor whiteColor];
        imgTipo.image  = [UIImage imageNamed:[NSString stringWithFormat:@"tipo%d.png", tipoEstabelecimento.idTipo]];
    } else {
        tipo.textColor = [UIColor blackColor];
        imgTipo.image  = [UIImage imageNamed:@"desativado.png"];
    }
    tipo.text = tipoEstabelecimento.descricao;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
