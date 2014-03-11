//
//  ListaCell.h
//  Inveni
//
//  Created by Guilherme Augusto on 05/11/13.
//  Copyright (c) 2013 Primus Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Estabelecimento.h"
#import <CoreLocation/CoreLocation.h>

@protocol ListaCellDelegate <NSObject>

-(void) detalhesEstabelecimento:(Estabelecimento*) estabelecimento;
-(void) reservarEstabelecimento:(Estabelecimento*) estabelecimento;

@end

@interface ListaCell : UICollectionViewCell{
    id <ListaCellDelegate> delegate;
}

@property (weak, nonatomic) IBOutlet UILabel *nome;
@property (weak, nonatomic) IBOutlet UILabel *endereco;
@property (weak, nonatomic) IBOutlet UILabel *distancia;
@property (weak, nonatomic) IBOutlet UILabel *telefone;
@property (weak, nonatomic) IBOutlet UIButton *btnReservar;
@property (weak, nonatomic) IBOutlet UILabel *lblTelefone;
@property (nonatomic) id delegate;
@property (nonatomic) int indiceArray;

- (IBAction)btnReservarClick:(id)sender;

-(ListaCell*) iniciarComEstabelecimento:(Estabelecimento*) estabelecimento localizacaoUsuario:(CLLocation*)localizacaoUsuario delegate:(id) dele indice:(int) indiceArray;

@end