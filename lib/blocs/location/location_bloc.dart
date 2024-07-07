import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;


part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription? positionStream;
  LocationBloc() : super(LocationState()) {

    on<OnStartFollowingUser>((event, emit)=> emit(state.copyWith(followingUser:true)));
        on<OnStopFollowingUser>((event, emit)=> emit(state.copyWith(followingUser:true)));


    on<OnNewUserLocationEvent>((event, emit) {
        emit(state.copyWith(
          lastKnownLocation: event.newLocation,
          myLocationHistory: [...state.myLocationHistory,event.newLocation],
        ));
          });
  }

      Future getCurrentPosition()async{
      final position =  await Geolocator.getCurrentPosition();
      print('Position: $position');

      }
      void startFollowingUser(){
        add(OnStartFollowingUser());
        print('startFollowingUser');
        positionStream=Geolocator.getPositionStream().listen((event) {
          final position =event;
          add(OnNewUserLocationEvent(LatLng(position.latitude, position.longitude) ));
          print('position:$position');
        });
      }

      void stopFollowingUser(){
        positionStream?.cancel();
        add(OnStopFollowingUser());
        print('StopFollowingUser');
      }

      @override
  Future<void> close() {
    positionStream?.cancel();
    // TODO: implement close
    return super.close();
  }

}
