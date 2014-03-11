//
//  MenuViewController.m
//  Inveni
//
//  Created by Guilherme Augusto on 01/11/13.
//  Copyright (c) 2013 Primus Tech. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@property (strong, nonatomic) NSMutableArray *tipos;

@end

@implementation MenuViewController

@synthesize tabela;
@synthesize tipos;
@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    tabela.delegate = self;
    tabela.dataSource = self;
    
    tipos = [NSMutableArray new];
    tipos = [NSMutableArray arrayWithArray:[TipoEstabelecimento getAll]];
}

#pragma mark - TableViewDelegate

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tipos count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *menuCell = @"MenuCell";
    
    MenuCell *cell = (MenuCell *)[tabela dequeueReusableCellWithIdentifier:menuCell];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:menuCell owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    TipoEstabelecimento *tipo = [tipos objectAtIndex:indexPath.row];
    cell.tipoEstabelecimento = tipo;
    [cell prepareForReuse];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TipoEstabelecimento *tipoSelecionado = [tipos objectAtIndex:indexPath.row];
    tipoSelecionado.ativo = !tipoSelecionado.ativo;
    [tipoSelecionado save:nil];
    
    [tabela reloadData];
    
    if (self.delegate && [self.delegate respondsToSelector: @selector(onClicouTipo)]) {
        [self.delegate onClicouTipo];
    }
}

@end
