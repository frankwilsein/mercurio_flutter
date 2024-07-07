import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mercurio/blocs/blocs.dart';
import 'package:mercurio/blocs/search/search_bloc.dart';
import 'package:mercurio/helpers/helpers.dart';
import 'package:mercurio/models/route_destination.dart';
import 'package:mercurio/screens/map_screen.dart';
import 'package:mercurio/themes/themes.dart';
 

import 'package:mercurio/models/models.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  LatLng? mapCenter;

  StreamSubscription<LocationState>? locationStateSubscription;
  
  MapBloc({
    required this.locationBloc
  }) : super( const MapState() ) {
    
    on<OnMapInitialzedEvent>( _onInitMap );
    on<OnStartFollowingUserEvent>( _onStartFollowingUser );
    on<OnStopFollowingUserEvent>((event, emit) => emit( state.copyWith( isFollowingUser: false) ));
    on<UpdateUserPolylineEvent>( _onPolylineNewPoint );
    on<OnToggleUserRoute>((event, emit) => emit( state.copyWith( showMyRoute: !state.showMyRoute )) );

    on<DisplayPolylinesEvent>((event, emit)=>emit(state.copyWith(polylines: event.polylines,markers: event.markers)));
    on<DisplayPolylinesEvent2>((event, emit)=>emit(state.copyWith(polylines: event.polylines,markers: event.markers)));
    on<DisplayPolylinesEvent3>((event, emit)=>emit(state.copyWith(polylines: event.polylines,markers: event.markers)));
    //on<showComancom>(_,title);



    locationStateSubscription = locationBloc.stream.listen(( locationState ) {

      if(  locationState.lastKnownLocation != null ) {
        add( UpdateUserPolylineEvent( locationState.myLocationHistory ) );
      }

      if ( !state.isFollowingUser ) return;
      if( locationState.lastKnownLocation == null ) return;

      moveCamera( locationState.lastKnownLocation! );

    });

  }


  void _onInitMap( OnMapInitialzedEvent event, Emitter<MapState> emit ) {

    _mapController = event.controller;
    // ignore: deprecated_member_use
    _mapController!.setMapStyle( jsonEncode( uberMapTheme ));

    emit( state.copyWith( isMapInitialized: true ) );

  }

  void _onStartFollowingUser(OnStartFollowingUserEvent event, Emitter<MapState> emit) {

    emit( state.copyWith( isFollowingUser: true ) );

    if( locationBloc.state.lastKnownLocation == null ) return;
    moveCamera(locationBloc.state.lastKnownLocation!);

  }

  void _onPolylineNewPoint(UpdateUserPolylineEvent event, Emitter<MapState> emit) {

    final myRoute = Polyline(
      polylineId: const PolylineId('myRoute'),
      color: Colors.black,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: event.userLocations
    );

    final currentPolylines = Map<String, Polyline>.from( state.polylines );
    currentPolylines['myRoute'] = myRoute;

    emit( state.copyWith( polylines: currentPolylines ) );

  }
   @override
  Widget? showComancom(BuildContext _, String title) {
        return AlertDialog(
          title: const Text('Basic dialog title'),
          content: Text(title),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(_).textTheme.labelLarge,
              ),
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(_).pop();
              },
            ),

          ],
        );
      }

    Future drawRoutePolyline( RouteDestination destination ) async {

    final myRoute = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.black,
      width: 5,
      points: destination.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );
     
    final startMarker = Marker(
      markerId: const MarkerId('start'),
      position: destination.points.first
    );


    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: destination.points.last,
      //icon: endMarker, 
      /* RouteDestination({
    required this.points, 
    required this.duration, 
    required this.distance
  });*/
      // anchor: const Offset(0,0),
      // infoWindow: InfoWindow(
      //   title: destination.endPlace.text,
      //   snippet: destination.endPlace.placeName,
      // )EM long :-73,990593 lat:40,740121
    );


    final curretPolylines = Map<String, Polyline>.from( state.polylines );
    curretPolylines['route'] = myRoute;

    final currentMarkers = Map<String, Marker>.from( state.markers );
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;

    add( DisplayPolylinesEvent( curretPolylines, currentMarkers ) );

  }
  Future drawRoutePolyline2( RouteDestination destination) async {

        //String titleaux= '${title1}';
    final myRoute = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.red,
      width: 5,
      points: destination.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );
             final startMaker=await getAssetImageMarker();

    final startMarker = Marker(
      markerId: const MarkerId('start'),
      position: destination.points.first,
      icon: startMaker,
      infoWindow:  InfoWindow(
        title: destination.title,
        snippet:destination.title ,
      onTap: () {
        //Navigator.push(MapView( ) as BuildContext, 'simplan');
      },
      ),


    );


    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: destination.points.last,
      //icon: endMarker, 
      /* RouteDestination({
    required this.points, 
    required this.duration, 
    required this.distance
  });*/
      // anchor: const Offset(0,0),
      // infoWindow: InfoWindow(
      //   title: destination.endPlace.text,
      //   snippet: destination.endPlace.placeName,
      // )EM long :-73,990593 lat:40,740121
    );


    final curretPolylines = Map<String, Polyline>.from( state.polylines );
    curretPolylines['route'] = myRoute;

    final currentMarkers = Map<String, Marker>.from( state.markers );
    currentMarkers['start'] = startMarker;
    //currentMarkers['end'] = endMarker;

    add( DisplayPolylinesEvent2( curretPolylines, currentMarkers ) );

  }

   Future drawRoutePolyline3( RouteDestination destination0, destination1,
    destination2, destination3,destination4,destination5,destination6,destination7,) async {

        //String titleaux= '${title1}';
    final myRoute1 = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.red,
      width: 5,
      points: destination0.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );
        final myRoute2 = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.red,
      width: 5,
      points: destination1.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );
        final myRoute3 = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.red,
      width: 5,
      points: destination2.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );
        final myRoute4 = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.red,
      width: 5,
      points: destination3.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );
        final myRoute5 = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.red,
      width: 5,
      points: destination4.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );
        final myRoute6 = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.red,
      width: 5,
      points: destination5.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );
        final myRoute7 = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.red,
      width: 5,
      points: destination6.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );
        final myRoute8 = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.red,
      width: 5,
      points: destination7.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );
    
    final startMaker=await getAssetImageMarker();

    final startMarker0 = Marker(
      markerId: const MarkerId('start'),
      position: destination0.points.first,
      icon: startMaker,
      infoWindow:  InfoWindow(
        title: destination0.title,
        snippet:destination0.snippet ,
      onTap: () {
        //Navigator.push(MapView( ) as BuildContext, 'simplan');
      },
      ),
    );
        final startMarker1 = Marker(
      markerId: const MarkerId('start'),
      position: destination1.points.first,
      icon: startMaker,
      infoWindow:  InfoWindow(
        title: destination1.title,
        snippet:destination1.snippet ,
      onTap: () {
        //Navigator.push(MapView( ) as BuildContext, 'simplan');
      },
      ),      
    );
            final startMarker2 = Marker(
      markerId: const MarkerId('start'),
      position: destination2.points.first,
      icon: startMaker,
      infoWindow:  InfoWindow(
        title: destination2.title,
        snippet:destination2.snippet ,
      onTap: () {
        //Navigator.push(MapView( ) as BuildContext, 'simplan');
      },
      ),      
    );
            final startMarker3 = Marker(
      markerId: const MarkerId('start'),
      position: destination3.points.first,
      icon: startMaker,
      infoWindow:  InfoWindow(
        title: destination3.title,
        snippet:destination3.snippet ,
      onTap: () {
        //Navigator.push(MapView( ) as BuildContext, 'simplan');
      },
      ),      
    );
            final startMarker4 = Marker(
      markerId: const MarkerId('start'),
      position: destination4.points.first,
      icon: startMaker,
      infoWindow:  InfoWindow(
        title: destination4.title,
        snippet:destination4.snippet ,
      onTap: () {
        //Navigator.push(MapView( ) as BuildContext, 'simplan');
      },
      ),      
    );
            final startMarker5 = Marker(
      markerId: const MarkerId('start'),
      position: destination5.points.first,
      icon: startMaker,
      infoWindow:  InfoWindow(
        title: destination5.title,
        snippet:destination5.snippet ,
      onTap: () {
        //Navigator.push(MapView( ) as BuildContext, 'simplan');
      },
      ),      
    );
            final startMarker6 = Marker(
      markerId: const MarkerId('start'),
      position: destination6.points.first,
      icon: startMaker,
      infoWindow:  InfoWindow(
        title: destination6.title,
        snippet:destination6.snippet ,
      onTap: () {
        //Navigator.push(MapView( ) as BuildContext, 'simplan');
      },
      ),      
    );
            final startMarker7 = Marker(
      markerId: const MarkerId('start'),
      position: destination7.points.first,
      icon: startMaker,
      infoWindow:  InfoWindow(
        title: destination7.title,
        snippet:destination7.snippet ,
      onTap: () {
        //Navigator.push(MapView( ) as BuildContext, 'simplan');
      },
      ),      
    );


    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: destination0.points.last,
    );


    final curretPolylines = Map<String, Polyline>.from( state.polylines );
    curretPolylines['route'] = myRoute1;myRoute2;myRoute3;myRoute4;myRoute5;myRoute6;myRoute7;myRoute8;

    final currentMarkers = Map<String, Marker>.from( state.markers );
    currentMarkers['start'] = startMarker1;startMarker2;startMarker3;startMarker4;startMarker5;startMarker6;startMarker7;
    //currentMarkers['end'] = endMarker;

    add( DisplayPolylinesEvent3( curretPolylines, currentMarkers ) );

  }




  void moveCamera( LatLng newLocation ) {
    final cameraUpdate = CameraUpdate.newLatLng( newLocation );
    _mapController?.animateCamera(cameraUpdate);
  }

    
  @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }
}
