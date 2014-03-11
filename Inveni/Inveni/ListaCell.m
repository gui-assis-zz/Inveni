//
//  ListaCell.m
//  Inveni
//
//  Created by Guilherme Augusto on 05/11/13.
//  Copyright (c) 2013 Primus Tech. All rights reserved.
//

#import "ListaCell.h"

@implementation ListaCell{
    
}

@synthesize nome = _nome;
@synthesize endereco = _endereco;
@synthesize lblTelefone = _lblTelefone;
@synthesize telefone = _telefone;
@synthesize distancia = _distancia;
@synthesize delegate = _delegate;
@synthesize indiceArray = _indiceArray;
@synthesize btnReservar;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ListaCell" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
    }
    
    [[self delegate] respondsToSelector:@selector(reservarEstabelecimento:)];
    [[self delegate] respondsToSelector:@selector(detalhesEstabelecimento:)];
    
    return self;
}

-(ListaCell*) iniciarComEstabelecimento:(Estabelecimento *)estabelecimento localizacaoUsuario:(CLLocation *)localizacaoUsuario delegate:(id)dele indice:(int)indiceArray{
    _delegate = dele;
    _nome.text = estabelecimento.nome;
    _endereco.text = estabelecimento.endereco;
    _telefone.text = estabelecimento.telefone;
    _indiceArray = indiceArray;
    
    CLLocation *localizacao = [[CLLocation alloc] initWithLatitude:estabelecimento.latitude longitude:estabelecimento.longitude];
    
    if (localizacaoUsuario.coordinate.latitude != 0.0f && localizacaoUsuario.coordinate.longitude != 0.0f) {
        CLLocationDistance distance = [localizacao distanceFromLocation:localizacaoUsuario];
        _distancia.hidden = NO;
        _distancia.text = [NSString stringWithFormat:@"%.1f Km", distance/1000];
    } else {
        _distancia.hidden = YES;
    }
    
    return self;
}

- (IBAction)btnReservarClick:(id)sender {
}

@end
