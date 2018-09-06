//
//  MGSuperMapView.h
//  MapGameiPhone
//
//  Created by Michael Dietz on 08.07.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@protocol SuperMapDelegate

@optional
-(void)zoomLevelChanged:(int)newZoomLevel;

@end


@interface ImprovedMapView : MKMapView {

	NSUInteger currentZoomLevel;
	
}

@property(assign) NSUInteger currentZoomLevel;


-(void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate zoomLevel:(NSUInteger)zoomLevel animated:(BOOL)animated;
-(void)setZoomLevel:(NSUInteger)zoomLevel animated:(BOOL)animated;
-(void)setInitialMapState;
-(void)regionChanged;
-(NSUInteger)calculateZoomLevel;

@end
