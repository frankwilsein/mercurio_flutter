import 'package:dio/dio.dart';



class TrafficInterceptor extends Interceptor {

  final accessToken = 'pk.eyJ1IjoiZnJhbmt3aWxzZWluIiwiYSI6ImNseGc4Z2RqMTEwMXMyanB2ZW14cGdkbWUifQ.Whwz0dIj2DQk4-gubLRzNA';
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': accessToken
    });


    super.onRequest(options, handler);
  }


}