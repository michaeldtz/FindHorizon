//
//  GeoCalculation.h
//  Horizon
//
//  Created by Michael Dietz on 07.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GeoCalculation : NSObject {

}

-(CLLocationCoordinate2D)calculateLocationByLocation:(CLLocationCoordinate2D)coordinate angle:(float)angle andDistance:(float)distance;

@end
