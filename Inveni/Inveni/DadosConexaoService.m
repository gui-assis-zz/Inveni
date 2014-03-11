//
//  DadosConexaoService.m
//  ControleVisitas
//
//  Created by Marcio Manske on 22/07/11.
//  Copyright 2011 CMNet Solucoes em Infotmatica. All rights reserved.
//

#import "DadosConexaoService.h"
#import "AppHelper.h"

@interface DadosConexaoService ()

+(NSString*)getURLConexao:(NSString*)contexto;

@end

@implementation DadosConexaoService

+(NSString*)getURLConexao:(NSString*)contexto{
    NSString *mac = [AppHelper getMacAddressDevice];

    NSMutableString *servidor = [[NSMutableString alloc] initWithString:@""];
    int porta = 0;
    BOOL multiPDV = NO;
    
    
    if ([servidor isEqualToString:@""] || porta == 0) {
        return nil;
    }
    
    if (multiPDV) {
        return [NSString stringWithFormat:@"http://%@:%d/MultiPdvService/preVenda/%@/%@", servidor, porta, contexto, mac];
    } else {
        return [NSString stringWithFormat:@"http://%@:%d/prevenda/%@/%@", servidor, porta, contexto, mac];
    }
    
}

+(NSString*)getURLConexaoForServico:(NSString*)contexto{
    return [DadosConexaoService getURLConexao:contexto];
}

@end