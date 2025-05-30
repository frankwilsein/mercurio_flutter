import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mercurio/blocs/blocs.dart';

class GpsAccesScreen extends StatelessWidget {
  const GpsAccesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: BlocBuilder<GpsBloc, GpsState>(
          builder: (context, state) {
            //print('state:$state');
            return !state.isGpsEnabled 
            ?const _EnableGpsMessage()
            : const _AccessButton();
          },
        )
        //_AccessButton(),
      ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Es Necesario el acceso a GPS'),
        MaterialButton(
          child: const Text('Solicitar Acceso', style: TextStyle(color: Colors.white ),),
          color: Color.fromARGB(255, 107, 9, 1),
          shape: const StadiumBorder(),
          elevation: 0,
          splashColor: Colors.transparent,
          onPressed: (){
            final gpsBloc= BlocProvider.of<GpsBloc>(context);
            gpsBloc.askGpsAcces();

        })
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text('Debe habilitar el GPS',
    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300
    )
    ,);
  }
}