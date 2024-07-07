
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:mercurio/models/places_models.dart';


class RouteDestination {

  final List<LatLng> points;
  final double duration;
  final double distance;
  final Feature endPlace;
  final String ?title;
  final String ?snippet;

  RouteDestination({
    required this.points, 
    required this.duration, 
    required this.distance,
    required this.endPlace,
    required this.title,
    required this.snippet, 
  });

}