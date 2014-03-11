//
//  BaseService.h
//  ControleVisitas
//
//  Created by Marcio Manske on 01/08/11.
//  Copyright 2011 CMNet Solucoes em Infotmatica. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DadosConexaoService.h"
#import "JSONObjects.h"

@interface BaseService : NSObject  {

}

@property (nonatomic, unsafe_unretained) id delegate;
@property (nonatomic, strong)  NSString *dadosRetorno;
@property (nonatomic, strong)  NSMutableData *dataRetorno;
@property (nonatomic) BOOL deuTimeOut;
@property (nonatomic) NSTimer *timeOutTimer;
@property (nonatomic) NSURLConnection *conexao;

- (void)timerFireMethod:(NSTimer*)theTime;


-(void)trataRecebimento;
-(void)onTimeOutConnection;
-(void)fazConsulta: (NSString*) codigo sUrl:(NSString*)sUrl timeOut:(int)timeOut;
-(void)enviaMensagemErro:(NSString*) msgErro;
-(NSString*)confereURLConexao: (NSString*) contexto;

#pragma mark Cargas

-(void) cargaPreliminar:(NSString*) url timeOut:(int) timeOut;

@end


@interface NSObject(BaseServiceDelegate)

-(void) onOcorreuTimeout:(NSString*) msg;
-(void) onRecebeuDados;

@end