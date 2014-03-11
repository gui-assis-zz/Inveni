//
//  TipoEstabelecimento.h
//  Inveni
//
//  Created by Guilherme Augusto on 05/11/13.
//  Copyright (c) 2013 Primus Tech. All rights reserved.
//

#import "Model+JSONKit.h"

@interface TipoEstabelecimento : Model

@property (nonatomic, retain) NSString * descricao;
@property (nonatomic) BOOL ativo;
@property (nonatomic) int16_t idTipo;

@end
