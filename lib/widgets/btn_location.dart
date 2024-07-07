import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mercurio/blocs/blocs.dart';
import 'package:mercurio/ui/ui.dart';


class BtnCurrentLocation extends StatelessWidget {
  const BtnCurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final locationBloc =BlocProvider.of<LocationBloc>(context);
    final mapBloc =BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom:10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius:25,
        child: IconButton(
          icon: const Icon(Icons.my_location_outlined, color: Colors.black ),
          onPressed: (){
              final userLocation = locationBloc.state.lastKnownLocation;


              //return;
              if(userLocation == null){
                
              final snack = CustomSnackbar(message: 'No hay Ubicaion');
              ScaffoldMessenger.of(context).showSnackBar(snack);
              return;
              };

              mapBloc.moveCamera(userLocation);
          },
        ),
      ),
    );
  }
}