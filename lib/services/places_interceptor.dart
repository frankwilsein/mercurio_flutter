import 'package:dio/dio.dart';


class PlacesInterceptor extends Interceptor {
  
  final accessToken = 'pk.eyJ1IjoiZnJhbmt3aWxzZWluIiwiYSI6ImNseGc4Z2RqMTEwMXMyanB2ZW14cGdkbWUifQ.Whwz0dIj2DQk4-gubLRzNA';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
    options.queryParameters.addAll({
      'access_token': accessToken,
      'language': 'es',
    });


    super.onRequest(options, handler);
  }

}