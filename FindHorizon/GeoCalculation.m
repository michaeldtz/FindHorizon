	//
	//  GeoCalculation.m
	//  Horizon
	//
	//  Created by Michael Dietz on 07.01.11.
	//  Copyright 2011 __MyCompanyName__. All rights reserved.
	//

#import "GeoCalculation.h"


@implementation GeoCalculation

-(CLLocationCoordinate2D)calculateLocationByLocation:(CLLocationCoordinate2D)coordinate angle:(float)angle andDistance:(float)distance{
	
	NSLog(@"Latitue: %f, Longitude:%f, Angle:%f, Distance:%f",coordinate.latitude, coordinate.longitude, angle, distance);
	
	double angleRadians = (angle) * M_PI / 180;

	CLLocationCoordinate2D newCoordinate;

	double latDist = (cos(angleRadians) * distance);
	double logDist = (sin(angleRadians) * distance);
	NSLog(@"latDist: %f, logDist: %f", latDist, logDist);

	double latMin = 1850 * cos( coordinate.latitude * M_PI / 180 );
	NSLog(@"LatMin %f", latMin);
	
	double latDiff = (latDist / ( 1850 * 60 ));
	double logDiff = logDist / ( latMin * 60);
	NSLog(@"latDiff: %f, logDiff: %f", latDiff, logDiff);
	
	newCoordinate.latitude  = coordinate.latitude  + latDiff;
	newCoordinate.longitude = coordinate.longitude + logDiff;
	NSLog(@"Latitue: %f, Longitude:%f",newCoordinate.latitude, newCoordinate.longitude);
	
	return newCoordinate;
}

@end
