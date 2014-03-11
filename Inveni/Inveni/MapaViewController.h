//
//  MapaViewController.h
//  Inveni
//
//  Created by Guilherme Augusto on 31/10/13.
//  Copyright (c) 2013 Primus Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "REFrostedViewController.h"
#import "Estabelecimento.h"
#import "EstabelecimentoService.h"
#import "MenuViewController.h"
#import "Configuracao.h"

#import "SalaoPoint.h"
#import "RestaurantePoint.h"
#import "ConsultorioPoint.h"
#import "CustomPin.h"
#import "CustomAnnotationViewButton.h"

@interface MapaViewController : UIViewController<MKMapViewDelegate, REFrostedViewControllerDelegate, MenuViewControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapa;
@property (strong, nonatomic) NSMutableArray *estabelecimentos;

- (IBAction)showMenuClick:(id)sender;
- (IBAction)zoomIn:(id)sender;
- (IBAction)zoomOut:(id)sender;
- (IBAction)goToUserLocation:(id)sender;

@end
