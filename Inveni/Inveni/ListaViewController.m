//
//  ListaViewController.m
//  Inveni
//
//  Created by Guilherme Augusto on 31/10/13.
//  Copyright (c) 2013 Primus Tech. All rights reserved.
//

#import "ListaViewController.h"

@interface ListaViewController ()<CLLocationManagerDelegate>{
    EstabelecimentoService *estabService;
    CLLocationManager      *locationManager;
    CLLocation             *userLocation;
}

@property (strong, nonatomic) NSMutableArray *estabs;

@end

@implementation ListaViewController

@synthesize tabela, estabs;

- (void)viewDidLoad
{
    [super viewDidLoad];
    estabService = [EstabelecimentoService new];
    estabService.delegate = self;
    
    estabs = [NSMutableArray new];
    
    userLocation = [[CLLocation alloc] init];

    tabela.delegate = self;
    tabela.dataSource = self;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self atualizarLocalizacaoDoUsuario];
    
    [tabela registerClass:[ListaCell class] forCellWithReuseIdentifier:@"ListaCell"];
}

-(void) viewDidAppear:(BOOL)animated{
    self.frostedViewController.delegate = self;
    ((MenuViewController*) self.frostedViewController.menuViewController).delegate = self;
    [self atualizarLista];
}

#pragma mark - CollectionViewDelegate
-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //Selecionou estab
}

-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Estabelecimento *estabelecimento = [estabs objectAtIndex:indexPath.row];
    ListaCell *cell = (ListaCell*)[tabela dequeueReusableCellWithReuseIdentifier:@"ListaCell" forIndexPath:indexPath];
    cell = [cell iniciarComEstabelecimento:estabelecimento localizacaoUsuario:userLocation delegate:self indice:indexPath.row];
    return cell;
}

-(int) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [estabs count];
}

-(int) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(void) atualizarLista{
    [self retornouEstabelecimentos:[NSMutableArray arrayWithArray:[Estabelecimento getAll]]];
    [tabela reloadData];
}

#pragma mark - ListaCellDelegate

-(void) detalhesEstabelecimento:(Estabelecimento *)estabelecimento{
    
}

-(void) reservarEstabelecimento:(Estabelecimento *)estabelecimento{
    
}

#pragma mark - EstabelecimentoServiceDelegate

-(void) retornouEstabelecimentos:(NSMutableArray *)estabelecimentos{
    [estabs removeAllObjects];
    for (Estabelecimento *estab in estabelecimentos) {
        if (estab.tipo.ativo) {
            [estabs addObject:estab];
        }
    }
}

#pragma mark - Controls

- (IBAction)showMenuClick:(id)sender {
    [self.frostedViewController presentMenuViewController];
}

#pragma mark - CLLocationManagerDelegate

-(void) atualizarLocalizacaoDoUsuario{
    [locationManager stopUpdatingLocation];
    [locationManager startUpdatingLocation];
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    userLocation = [locations lastObject];
    [tabela reloadData];
}

#pragma mark - REFrostedViewControllerDelegate

-(void) frostedViewController:(REFrostedViewController *)frostedViewController willHideMenuViewController:(UIViewController *)menuViewController{
    [self atualizarLista];
}

#pragma mark - MenuViewControllerDelegate

-(void) onClicouTipo{
    [self atualizarLista];
}

@end
