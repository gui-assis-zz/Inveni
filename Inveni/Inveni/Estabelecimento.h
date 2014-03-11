//
//  Estabelecimento.h
//  Inveni
//
//  Created by Guilherme Augusto on 05/11/13.
//  Copyright (c) 2013 Primus Tech. All rights reserved.
//

#import "Model+JSONKit.h"

@class TipoEstabelecimento;

@interface Estabelecimento : Model

@property (nonatomic, retain) NSString * endereco;
@property (nonatomic) float latitude;
@property (nonatomic) float longitude;
@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSString * telefone;
@property (nonatomic, retain) TipoEstabelecimento *tipo;

@end
