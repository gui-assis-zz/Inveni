//
//  EstabelecimentoService.h
//  Inveni
//
//  Created by Guilherme Augusto on 04/11/13.
//  Copyright (c) 2013 Primus Tech. All rights reserved.
//

#import "BaseService.h"
#import "Estabelecimento.h"
#import "TipoEstabelecimento.h"
#import <MapKit/MapKit.h>

@interface EstabelecimentoService : BaseService

-(NSMutableArray*) carregarEstabelecimentos;
-(void) inserirTipos;

@end

@interface NSObject (EstabelecimentoDelegate)

-(void) retornouEstabelecimentos:(NSMutableArray*)estabelecimentos;
-(void) retornouEstabelecimentosErro:(NSString*) msgErro;

@end
