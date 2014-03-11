//
//  BaseService.m
//  ControleVisitas
//
//  Created by Marcio Manske on 01/08/11.
//  Copyright 2011 CMNet Solucoes em Infotmatica. All rights reserved.
//

#import "BaseService.h"
#import "AppHelper.h"

@implementation BaseService                                                                                                                                                                                                            

@synthesize dadosRetorno, delegate, timeOutTimer, conexao, deuTimeOut, dataRetorno;

- (void)timerFireMethod:(NSTimer*)theTime {
    [self onTimeOutConnection];
    [conexao cancel];
    self.conexao = nil;
}

-(id) init {
    self = [super init];
    if (self) {
        self.dadosRetorno = nil;
        self.conexao = nil;
        self.dataRetorno = nil;
        return self;
    }
    return nil;
}

-(NSString*) confereURLConexao: (NSString*) contexto {
    NSString *strURL = [DadosConexaoService getURLConexaoForServico:contexto];
    
    if (strURL == nil) {
        [self enviaMensagemErro:@"Informe o Servidor nos Ajustes"];
    }
    return strURL;
}

-(void) cargaPreliminar:(NSString *)url timeOut:(int)timeOut{
    self.deuTimeOut = NO;
    NSString *strUrl = [NSString stringWithFormat:@"%@", url];
    NSURL *sUrl = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *request = [NSURLRequest requestWithURL:sUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
    
    [self conecta:request timeOut:timeOut];
}

-(void) fazConsulta: (NSString*) codigo sUrl:(NSString*)sUrl timeOut:(int)timeOut{
    self.deuTimeOut = NO;
    NSString *strUrl = [NSString stringWithFormat:@"%@/%@", sUrl, [codigo stringByReplacingOccurrencesOfString:@" " withString:@"#32"]];
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
    
    [self conecta:request timeOut:timeOut];
}

-(void)onTimeOutConnection {
    self.deuTimeOut = YES;
    if (delegate && [delegate respondsToSelector:@selector(onOcorreuTimeout:)]) {
        [delegate onOcorreuTimeout:@"Timeout na conexão!"];
    }
}

-(void)trataRecebimento {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onRecebeuDados)]) {
        [self.delegate onRecebeuDados];
    }
}

-(void) enviaMensagemErro:(NSString*) msgErro {
    
}

-(void) conecta: (NSMutableURLRequest*) request timeOut:(int) timeOut{
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    self.conexao = conn;
    self.dadosRetorno = nil;
    self.dataRetorno = nil;
    self.dataRetorno = [NSMutableData new];
    
    self.timeOutTimer = [NSTimer scheduledTimerWithTimeInterval:timeOut target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:NO];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [dataRetorno appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [timeOutTimer invalidate];
    self.timeOutTimer = nil;
    if (!deuTimeOut) {
        if (dataRetorno) {
            NSString *aStr = [[NSString alloc] initWithData:dataRetorno encoding:NSUTF8StringEncoding];
            self.dadosRetorno = aStr;
        }
        [self trataRecebimento];
    }
    
    self.conexao = nil;
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [timeOutTimer invalidate];
    self.timeOutTimer = nil;
    if (!deuTimeOut) {
        NSString *msgError = [NSString stringWithFormat: @"%@", error.localizedDescription];
        [self enviaMensagemErro:msgError];
    }
    self.conexao = nil;
}


@end
