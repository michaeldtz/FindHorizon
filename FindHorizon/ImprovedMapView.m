//
//  MGSuperMapView.m
//  MapGameiPhone
//
//  Created by Michael Dietz on 08.07.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ImprovedMapView.h"

#define MERCATOR_OFFSET 268435456
#define MERCATOR_RADIUS 85445659.44705395

@implementation ImprovedMapView

@synthesize currentZoomLevel;

#pragma mark Map conversion methods

- (double)longitudeToPixelSpaceX:(double)longitude
{
    return round(MERCATOR_OFFSET + MERCATOR_RADIUS * longitude * M_PI / 180.0);
}

- (double)latitudeToPixelSpaceY:(double)latitude
{
    return round(MERCATOR_OFFSET - MERCATOR_RADIUS * logf((1 + sinf(latitude * M_PI / 180.0)) / (1 - sinf(latitude * M_PI / 180.0))) / 2.0);
}

- (double)pixelSpaceXToLongitude:(double)pixelX
{
    return (((round(pixelX) - MERCATOR_OFFSET) / MERCATOR_RADIUS) * 180.0 / M_PI);
}

- (double)pixelSpaceYToLatitude:(double)pixelY
{
    return (M_PI / 2.0 - 2.0 * atan(exp((round(pixelY) - MERCATOR_OFFSET) / MERCATOR_RADIUS))) * 180.0 / M_PI;
}

#pragma mark -
#pragma mark Helper methods

- (MKCoordinateSpan)coordinateSpanWithMapView:(MKMapView *)mapView
							 centerCoordinate:(CLLocationCoordinate2D)centerCoordinate
								 andZoomLevel:(NSUInteger)zoomLevel
{
		// convert center coordiate to pixel space
    double centerPixelX = [self longitudeToPixelSpaceX:centerCoordinate.longitude];
    double centerPixelY = [self latitudeToPixelSpaceY:centerCoordinate.latitude];
    
		// determine the scale value from the zoom level
    NSInteger zoomExponent = 20 - zoomLevel;
    double zoomScale = pow(2, zoomExponent);
    
		// scale the map’s size in pixel space
    CGSize mapSizeInPixels = mapView.bounds.size;
    double scaledMapWidth = mapSizeInPixels.width * zoomScale;
    double scaledMapHeight = mapSizeInPixels.height * zoomScale;
	
		// figure out the position of the top-left pixel
    double topLeftPixelX = centerPixelX - (scaledMapWidth / 2);
    double topLeftPixelY = centerPixelY - (scaledMapHeight / 2);
    
		// find delta between left and right longitudes
    CLLocationDegrees minLng = [self pixelSpaceXToLongitude:topLeftPixelX];
    CLLocationDegrees maxLng = [self pixelSpaceXToLongitude:topLeftPixelX + scaledMapWidth];
    CLLocationDegrees longitudeDelta = maxLng - minLng;
    
		// find delta between top and bottom latitudes
    CLLocationDegrees minLat = [self pixelSpaceYToLatitude:topLeftPixelY];
    CLLocationDegrees maxLat = [self pixelSpaceYToLatitude:topLeftPixelY + scaledMapHeight];
    CLLocationDegrees latitudeDelta = -1 * (maxLat - minLat);
    
		// create and return the lat/lng span
    MKCoordinateSpan span = MKCoordinateSpanMake(latitudeDelta, longitudeDelta);
    return span;
}

#pragma mark -
#pragma mark Public methods

-(NSUInteger)calculateZoomLevel{
	MKCoordinateRegion region = self.region;
	MKCoordinateSpan span = region.span;
	
	for(int i = 0; i < 20; i++){
		MKCoordinateSpan innerSpan = [self coordinateSpanWithMapView:self centerCoordinate:self.region.center andZoomLevel:i];
		if(span.longitudeDelta <= innerSpan.longitudeDelta){
			self.currentZoomLevel = i;  
		}
	}
	return currentZoomLevel;
}

-(void)regionChanged{
	self.currentZoomLevel = [self calculateZoomLevel];
	
	/*if([super.delegate conformsToProtocol:@protocol(SuperMapDelegate)]){
		id<SuperMapDelegate> subDelegate = (id<SuperMapDelegate>)super.delegate;
		int zoom = self.currentZoomLevel;
		[subDelegate zoomLevelChanged:zoom];
	}*/
}

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
				  zoomLevel:(NSUInteger)zoomLevel
				   animated:(BOOL)animated
{
		// clamp large numbers to 28
    self.currentZoomLevel = MIN(zoomLevel, 28);
    
		// use the zoom level to compute the region
    MKCoordinateSpan span = [self coordinateSpanWithMapView:self centerCoordinate:centerCoordinate andZoomLevel:zoomLevel];
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, span);
    
		// set the region like normal
    [self setRegion:region animated:animated];
}

- (void)setZoomLevel:(NSUInteger)zoomLevel
			animated:(BOOL)animated{
	[self setCenterCoordinate:self.centerCoordinate zoomLevel:zoomLevel animated:animated];
}


-(void)setInitialMapState{
	CLLocationCoordinate2D coordinate;
	coordinate.latitude = 12.554564;
	coordinate.longitude = -4.921875;
	[self setCenterCoordinate:coordinate zoomLevel:0 animated:YES];
}

#pragma mark Lifecycle



@end
