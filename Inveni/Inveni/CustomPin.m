//
//  CustomPin.m
//  Inveni
//
//  Created by Guilherme Augusto on 05/11/13.
//  Copyright (c) 2013 Primus Tech. All rights reserved.
//

#import "CustomPin.h"

@implementation CustomPin

@synthesize imagem;
@synthesize descricao;
@synthesize estabelecimento = _estabelecimento;

-(CustomPin*) initWithEstabelecimento:(Estabelecimento*)estabelecimento{
    _estabelecimento = estabelecimento;
    
    self.coordinate = CLLocationCoordinate2DMake(estabelecimento.latitude, estabelecimento.longitude);
    self.title      = estabelecimento.nome;
    self.subtitle   = estabelecimento.endereco;
    
    imagem     = [UIImage imageNamed:[NSString stringWithFormat:@"tipo%d.png", estabelecimento.tipo.idTipo]];
    descricao  = [NSString stringWithFormat:@"tipo%d", estabelecimento.tipo.idTipo];
        
    return self;
}

@end
