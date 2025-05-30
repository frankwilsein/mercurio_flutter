import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mercurio/blocs/blocs.dart';


class MapView extends StatelessWidget {
  final LatLng initialLocation;

    final Set<Polyline> polylines;
    final Set<Marker> markers;

  const MapView({super.key, required this.initialLocation, required this.polylines, required this.markers});

  @override
  Widget build(BuildContext context) {

    final mapBloc= BlocProvider.of<MapBloc>(context);
    final CameraPosition initialCameraPosition=CameraPosition(
      target: initialLocation,
      zoom:14,
      

    );

    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Listener(
        onPointerMove: ( pointerMoveEvent )=> mapBloc.add( OnStopFollowingUserEvent() ),
        child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          compassEnabled: false,
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          myLocationButtonEnabled: false,
          polylines:   polylines,
          markers: markers,
          onMapCreated: ( controller ) => mapBloc.add( OnMapInitialzedEvent(controller) ),
          onCameraMove: ( position ) => mapBloc.mapCenter = position.target,
          

          

          // TODO: Markers
          // onCameraMove: ,
        ),
        
      ),
      
    );
  }

}