//
//  MapaViewController.m
//  Inveni
//
//  Created by Guilherme Augusto on 31/10/13.
//  Copyright (c) 2013 Primus Tech. All rights reserved.
//

#import "MapaViewController.h"
#import "CustomAnnotation.h"

@interface MapaViewController (){
    EstabelecimentoService *estabService;
}

@property (strong, nonatomic) NSMutableArray *estabs;

@end

@implementation MapaViewController

@synthesize mapa;
@synthesize estabs;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mapa.mapType = MKMapTypeStandard;
    mapa.delegate = self;
    mapa.showsUserLocation = YES;
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.03f, 0.03f);
    MKCoordinateRegion region = {mapa.userLocation.coordinate, span};
    MKCoordinateRegion regionThatFits = [mapa regionThatFits:region];
    
    [mapa setRegion:regionThatFits animated:NO];
    [mapa setMapType:MKMapTypeStandard];
    
    estabs = [NSMutableArray new];
    estabs = [estabService carregarEstabelecimentos];

}

-(void) viewDidAppear:(BOOL)animated{
    Configuracao *config = [Configuracao alloc];
    NSArray *configs = [Configuracao getAll];
    if ([configs count] > 0) {
        config = [configs objectAtIndex:0];
        [mapa setCenterCoordinate:CLLocationCoordinate2DMake(config.ultLatitude, config.ultLongitude) animated:YES];
    }
    
    self.frostedViewController.delegate = self;
    ((MenuViewController*) self.frostedViewController.menuViewController).delegate = self;
    [self atualizarMapa];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) retornouEstabelecimentos:(NSMutableArray *)estabelecimentos{
    for (Estabelecimento *estab in estabelecimentos) {
        if (estab.tipo.ativo) {
            CustomPin *annot = [[CustomPin alloc] initWithEstabelecimento:estab];
            [mapa addAnnotation:annot];
        }
    
    }
    [Model saveAll:nil];
}

#pragma mark -
#pragma mark MapViewDelegate

-(MKAnnotationView*) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{

    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    if ([annotation isKindOfClass:[CustomPin class]]) {
        
        NSString *identifier = ((CustomPin*) annotation).descricao;
        
        MKAnnotationView *pinView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (!pinView)
        {
            Estabelecimento *estab = ((CustomPin*) annotation).estabelecimento;
            
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            pinView.canShowCallout = YES;
            pinView.image = ((CustomPin*) annotation).imagem;
            pinView.calloutOffset = CGPointMake(0, 32);
            
            CustomAnnotationViewButton *btnObterRota = [CustomAnnotationViewButton buttonWithType:UIButtonTypeInfoLight];
            [btnObterRota addTarget:self action:@selector(obterRota:) forControlEvents:UIControlEventTouchUpInside];
            btnObterRota.estabelecimento = estab;
            
            pinView.rightCalloutAccessoryView = btnObterRota;
            
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    
    return nil;
}

-(void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    Configuracao *config = [Configuracao alloc];
    NSArray *configs = [Configuracao getAll];
    if ([configs count] > 0) {
        config = [configs objectAtIndex:0];
    } else {
        config = [Configuracao new];
    }
    config.ultLatitude       = userLocation.coordinate.latitude;
    config.ultLongitude      = userLocation.coordinate.longitude;
    
    [config save:nil];
}

-(void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
}

-(void) atualizarMapa{
    [self removeAllAnnotations];
    [self retornouEstabelecimentos:[NSMutableArray arrayWithArray:[Estabelecimento getAll]]];
}

-(void) createAndAddAnnotationForCoordinate : (CLLocationCoordinate2D) coordinate expectedTime:(NSTimeInterval) expectedTime{
    CustomAnnotation *annotation = [[CustomAnnotation alloc] initWithLocation:coordinate expectedTravelTime:expectedTime];
    [mapa addAnnotation: annotation];
}

#pragma mark -
#pragma mark ControlsActions

- (IBAction)showMenuClick:(id)sender {
    [self.frostedViewController presentMenuViewController];
}

- (IBAction)zoomIn:(id)sender {
    MKCoordinateRegion region = mapa.region;
    
    region.span.latitudeDelta /= 4;
    region.span.longitudeDelta /= 4;
    
    [mapa setRegion:region animated:YES];
}

- (IBAction)zoomOut:(id)sender {
    MKCoordinateRegion region = mapa.region;
    
    region.span.latitudeDelta *= 4;
    region.span.longitudeDelta *= 4;
    
    //Span Máximo
    if (region.span.latitudeDelta < 166.785235 && region.span.longitudeDelta < 135.773823) {
        [mapa setRegion:region animated:YES];
    }
}

- (IBAction)goToUserLocation:(id)sender {
    MKCoordinateRegion region = {mapa.userLocation.coordinate, mapa.region.span};
    MKCoordinateRegion regionThatFits = [mapa regionThatFits:region];
    
    [mapa setRegion:regionThatFits animated:YES];
}

-(void) obterRota:(CustomAnnotationViewButton*) sender{
    
    CLLocationCoordinate2D _srcCoord = CLLocationCoordinate2DMake(sender.estabelecimento.latitude, sender.estabelecimento.longitude);
    MKPlacemark *_srcMark = [[MKPlacemark alloc] initWithCoordinate:_srcCoord addressDictionary:nil];
    MKMapItem *_srcItem = [[MKMapItem alloc] initWithPlacemark:_srcMark];
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    
    request.source = [MKMapItem mapItemForCurrentLocation];
    
    request.destination = _srcItem;
    request.requestsAlternateRoutes = YES;
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler:
     ^(MKDirectionsResponse *response, NSError *error) {
         if (error) {
             // Handle Error
         } else {
             for (MKRoute *route in response.routes){
                 [mapa addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
                 MKMapPoint middlePoint = route.polyline.points[route.polyline.pointCount/2];
                 [self createAndAddAnnotationForCoordinate:MKCoordinateForMapPoint(middlePoint) expectedTime:route.expectedTravelTime];
//                 [self showRoute:response];
             }
         }
     }];
}

#pragma mark - REFrostedViewControllerDelegate

-(void) frostedViewController:(REFrostedViewController *)frostedViewController willHideMenuViewController:(UIViewController *)menuViewController{
    [self atualizarMapa];
}

-(void)removeAllAnnotations
{
    [mapa removeAnnotations:mapa.annotations];
    [mapa setShowsUserLocation:YES];
}

#pragma mark - MenuViewControllerDelegate

-(void) onClicouTipo{
    [self atualizarMapa];
}

#pragma mark - Route

-(void)showRoute:(MKDirectionsResponse *)response
{
    for (MKRoute *route in response.routes)
    {
        [mapa addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
        
        for (MKRouteStep *step in route.steps)
        {
            NSLog(@"%@", step.instructions);
        }
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    MKPolylineRenderer *renderer =
    [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor colorWithRed:0.5 green:0.5 blue:1.0 alpha:0.5];
    renderer.lineWidth = 5.0;
    return renderer;
}

@end
