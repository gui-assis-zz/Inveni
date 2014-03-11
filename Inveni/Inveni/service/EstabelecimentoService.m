//
//  EstabelecimentoService.m
//  Inveni
//
//  Created by Guilherme Augusto on 04/11/13.
//  Copyright (c) 2013 Primus Tech. All rights reserved.
//


// Tipo 1 - Salão
// Tipo 2 - Restaurantes e bares
// Tipo 3 - Consultórios médicos
// Tipo 4 - Pet Shops
// Tipo 5 - Dentistas
// Tipo 6 - Entretenimento



#import "EstabelecimentoService.h"

@implementation EstabelecimentoService

-(void) inserirTipos{
    TipoEstabelecimento *tipo1 = [TipoEstabelecimento new];
    tipo1.ativo = YES;
    tipo1.descricao = @"AAA";
    tipo1.idTipo = 1;
    
    TipoEstabelecimento *tipo2 = [TipoEstabelecimento new];
    tipo2.ativo = NO;
    tipo2.descricao = @"BBB";
    tipo2.idTipo = 2;
    
    TipoEstabelecimento *tipo3 = [TipoEstabelecimento new];
    tipo3.ativo = NO;
    tipo3.descricao = @"CCC";
    tipo3.idTipo = 3;
    
    TipoEstabelecimento *tipo4 = [TipoEstabelecimento new];
    tipo4.ativo = NO;
    tipo4.descricao = @"DDD";
    tipo4.idTipo = 4;
    
    TipoEstabelecimento *tipo5 = [TipoEstabelecimento new];
    tipo5.ativo = NO;
    tipo5.descricao = @"EEE";
    tipo5.idTipo = 5;
    
    TipoEstabelecimento *tipo6 = [TipoEstabelecimento new];
    tipo6.ativo = NO;
    tipo6.descricao = @"FFF";
    tipo6.idTipo = 6;
    
    [Model saveAll:nil];
}

-(NSMutableArray*) carregarEstabelecimentos{
    NSMutableArray *retorno = [NSMutableArray new];
    
    [Estabelecimento truncateNoSave];
    
    TipoEstabelecimento *tipo1 = [[TipoEstabelecimento getWithPredicate:@"idTipo = 1"] objectAtIndex:0];
    TipoEstabelecimento *tipo2 = [[TipoEstabelecimento getWithPredicate:@"idTipo = 2"] objectAtIndex:0];
    TipoEstabelecimento *tipo3 = [[TipoEstabelecimento getWithPredicate:@"idTipo = 3"] objectAtIndex:0];
    TipoEstabelecimento *tipo4 = [[TipoEstabelecimento getWithPredicate:@"idTipo = 4"] objectAtIndex:0];
    TipoEstabelecimento *tipo5 = [[TipoEstabelecimento getWithPredicate:@"idTipo = 5"] objectAtIndex:0];
    TipoEstabelecimento *tipo6 = [[TipoEstabelecimento getWithPredicate:@"idTipo = 6"] objectAtIndex:0];
    
    Estabelecimento *estab7 = [Estabelecimento new];
    estab7.nome = @"Wallace";
    estab7.latitude = -22.94234;
    estab7.longitude = -43.34125;
    estab7.tipo = tipo1;
    estab7.endereco = @"Estrada de Jacarepaguá, 870";
    estab7.telefone = @"(21)4637-3746";
    
    [retorno addObject:estab7];
    
    Estabelecimento *estab2 = [Estabelecimento new];
    estab2.nome = @"bbb";
    estab2.latitude = -22.98275;
    estab2.longitude = -43.36501;
    estab2.tipo = tipo2;
    estab2.endereco = @"Av. Ayrton Senna, 3000";
    estab2.telefone = @"(21)99283-9138";
    
    [retorno addObject:estab2];
    
    Estabelecimento *estab3 = [Estabelecimento new];
    estab3.nome = @"ccc";
    estab3.latitude = -22.99261;
    estab3.longitude = -43.36478;
    estab3.tipo = tipo3;
    estab3.endereco = @"Av. Ayrton Senna, 4000";
    estab3.telefone = @"(21)2934-9238";
    
    [retorno addObject:estab3];
    
    Estabelecimento *estab4 = [Estabelecimento new];
    estab4.nome = @"ddd";
    estab4.latitude = -22.97379;
    estab4.longitude = -43.37184;
    estab4.tipo = tipo4;
    estab4.endereco = @"Av. Embaixador Abelardo Bueno, 1060";
    estab4.telefone = @"(21)2748-9584";
    
    [retorno addObject:estab4];
    
    Estabelecimento *estab5 = [Estabelecimento new];
    estab5.nome = @"eee";
    estab5.latitude = -22.99901;
    estab5.longitude= -43.36083;
    estab5.tipo = tipo5;
    estab5.endereco = @"Av. das Américas, 3000";
    estab5.telefone = @"(21)2382-3482";
    
    [retorno addObject:estab5];
    
    Estabelecimento *estab6 = [Estabelecimento new];
    estab6.nome = @"fff";
    estab6.latitude = -22.97262;
    estab6.longitude = -43.38491;
    estab6.tipo = tipo6;
    estab6.endereco = @"Av. Embaixador Abelardo Bueno, 870";
    estab6.telefone = @"(21)4637-3746";
    
    [retorno addObject:estab6];
    
    [Model saveAll:nil];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(retornouEstabelecimentos:)]) {
        [self.delegate retornouEstabelecimentos:retorno];
    }
    
    return retorno;
}

@end
