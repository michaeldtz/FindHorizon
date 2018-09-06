	//
	//  PointOfInterest.m
	//  MapGame
	//
	//  Created by Michael Dietz on 07.07.10.
	//  Copyright 2010 __MyCompanyName__. All rights reserved.
	//

#import "MapLocation.h"


@implementation MapLocation

@synthesize coord;


-(CLLocationCoordinate2D)coordinate{
	return coord;
}

-(NSString*)getTitle{
    return atitle;
}

-(NSString*)getSubtitle{
    return asubtitle;
}

-(NSString*)title{
    return atitle;
}

-(NSString*)subtitle{
    return asubtitle;
}



-(MKAnnotationView *) mapView:(MKMapView *)mapView{
	
	MKPinAnnotationView* annView = [[MKPinAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"TARGET_PIN"];
    annView.pinColor = MKPinAnnotationColorGreen;
	annView.animatesDrop = NO;
	annView.canShowCallout = YES;
	annView.draggable = NO;
	annView.calloutOffset = CGPointMake(-5, 5);
	
	return annView;
}

#pragma mark Dealloc



@end
