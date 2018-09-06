	//
	//  PointOfInterest.h
	//  MapGame
	//
	//  Created by Michael Dietz on 07.07.10.
	//  Copyright 2010 __MyCompanyName__. All rights reserved.
	//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class MainViewController;

@interface MapLocation : MKAnnotationView <MKAnnotation>  {
	


	CLLocationCoordinate2D coord;

	NSString* atitle;
	NSString* asubtitle;

	BOOL      alreadyFalling;
}




@property CLLocationCoordinate2D coord;


-(MKAnnotationView *) mapView:(MKMapView *)mapView;

@end
