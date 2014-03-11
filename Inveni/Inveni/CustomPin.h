//
//  CustomPin.h
//  Inveni
//
//  Created by Guilherme Augusto on 05/11/13.
//  Copyright (c) 2013 Primus Tech. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "TipoEstabelecimento.h"
#import "Estabelecimento.h"

@interface CustomPin : MKPointAnnotation

@property (strong, nonatomic) UIImage *imagem;
@property (strong, nonatomic) NSString *descricao;
@property (strong, nonatomic) Estabelecimento *estabelecimento;

-(CustomPin*) initWithEstabelecimento:(Estabelecimento*) estabelecimento;

@end
