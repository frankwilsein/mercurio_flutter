import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mercurio/blocs/blocs.dart';
import 'package:mercurio/screens/screens.dart';

class SimplanPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    MultiBlocProvider(
      providers:[
      BlocProvider(create:(context) => GpsBloc())
    ],
      child: const MapScreen()
      );
    
    return const Scaffold(
      body: Center(
        child: LoadingScreen(),
      ),
    ); 
  }
}