import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mercurio/blocs/blocs.dart';
 enum _OntapWinner{none,dynamic}


class BtnComancom extends StatelessWidget {
  const BtnComancom({super.key});

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
          icon: const Icon(Icons.light_mode, color: Colors.black ),
          onPressed: (){       

                 onSearchResults( context );

          },
        ),
      ),
    );
  }

    void onSearchResults( BuildContext context) async {
    
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

   //Map<String,dynamic>  data ={"lapaz":-68.118493};

   final comancom1 = await searchBloc.getCoorsStartToEnd2(const LatLng(-16.510439,-68.118493) ,const LatLng(-17.974759,-67.108544) ,'191800-MAY-24 INICIO AL PLAN DE INSTALACION, MANTENIMIENTO Y CONFIGURACION DE EQUIPOS DE TELEFONIA','DESPLAZAMIENTO A LA DIV-2');
    final div2 = await searchBloc.getCoorsStartToEnd2(const LatLng(-17.974759,-67.108544) ,const LatLng(-21.459718,-65.705185) ,'DIV-2 200800-MAY-24 CONFIGURACION DE EQUIPOS AL COMPLETO, REVISION DE INVENTARIOS S/N-',' en la madrugada del 22-MAY-24 se registro la falla de un UPS, la misma levanto dos dias despues S/N');
 final div10 = await searchBloc.getCoorsStartToEnd2(const LatLng(-21.459718,-65.705185) 
         ,const LatLng(-21.259038,-63.472089) ,'DIV-10 230800-MAY-24-CONFIGURACION DE EQUIPOS AL COMPLETO',' REVISION DE INVENTARIOS S/N');
         final div3 = await searchBloc.getCoorsStartToEnd2(const LatLng(-21.259038,-63.472089) 
               ,const LatLng(-20.070771,-63.497646) 
               ,'DIV-3 280800-MAY-24 CONFIGURACION DE EQUIPOS PENDIENTE se esta realizando la',' configuracion de un FIREWALL en laboratorios de HANSA via remota-REVISION DE INVENTARIOS S/N.');
         final div4 = await searchBloc.getCoorsStartToEnd2(const LatLng(-20.070771,-63.497646) 
               ,const LatLng(-17.831693,-63.171017) 
               ,'DIV-4 310800-MAY-24  INSTALACION Y ENTREGA DE UN FIREWALL EVACUADO--','PRUEBAS DE TELEFONIA CON LA DIV-2 Y LA DIV-10 EXITOSAS-CONFIGURACION DE EQUIPOS AL COMPLETO-REVISION DE INVENTARIOS S/N.');
               final div8 = await searchBloc.getCoorsStartToEnd2(const LatLng(-17.831693,-63.171017) 
      ,const LatLng(-18.346882,-59.724561) 
      ,'DIV-8 040800-JUN-24  NO CUENTA CON CABLEADO DE INTERNET EN TELEFONIA(INSTALADO EN LA AYUDANTIA), NO CUENTA CON SERVICIO DE INTERNET(ENTEL)-- ','SE REALIZO EL RESTABLECIMIENTO DE SERVICIO DE INTERNET PARA LA DIV-8 Y PARA LA DIV-5 EN COORDINACION CON LA EMPRESA ENTEL, EXTENDIENDO MAS DE 100 MTS DE CABLE Y CAMBIANDO FIBRA OPTICA DANADA POR LA CAIDA DE UN ARBOL--  PRUEBAS DE TELEFONIA CON LA DIV-2 Y LA DIV-10 EXITOSAS-CONFIGURACION DE EQUIPOS AL COMPLETO-REVISION DE INVENTARIOS S/N.');
    final div5 = await searchBloc.getCoorsStartToEnd2(const LatLng(-18.346882,-59.724561) 
      ,const LatLng(-14.872969,-64.888371) 
      ,'DIV-5 060800-JUN-24  CABLEADO EXTERNO DE TELEFONIA INTERNA CORROIDO, ','SWITCH PRINCIPAL CON 6 PUERTOS QUEMADOS(2 EN REGULAR ESTADO)-NO CUENTA CON SERVICIO DE INTERNET(ENTEL)-- SE EVALUO Y DIAGNOSTICO EL CABLEADO CORROIDO ELABORANDO UN INFORME DE REPOSICION, NO SE INSTALO LA TELEFONIA INTERNA PARA PRECAUTELAR LOS EQUIPOS DE UNA POSIBLE DESCARGA ELECTRICA, SE REALIZO EL RESTABLECIMIENTO DE SERVICIO DE INTERNET EN COORDINACION CON LA EMPRESA ENTEL- PRUEBAS DE TELEFONIA CON LA DIV-2 Y LA DIV-10 EXITOSAS-CONFIGURACION DE EQUIPOS PARCIAL-REVISION DE INVENTARIOS S/N.');
    final div6 = await searchBloc.getCoorsStartToEnd2(const LatLng(-14.872969,-64.888371) 
      ,const LatLng(-11.089509,-68.694029) 
      ,'DIV-6 060800-JUN-24  UPS EN MAL ESTADO -- SE EVALUO Y DIAGNOSTICO EL UPS ELABORANDO UN INFORME DE REPOSICION, ','NO SE REALIZO PRUEBAS EN EQUIPOS PRECAUTELAR LOS EQUIPOS DE UNA POSIBLE DESCARGA ELECTRICA- PRUEBAS DE TELEFONIA CON LA DIV-2,10,4,8,5 EXITOSAS-CONFIGURACION DE EQUIPOS PARCIAL-REVISION DE INVENTARIOS S/N.');
     await mapBloc.drawRoutePolyline3(comancom1,div2,div10,div3,div4,div8,div5,div6);

   /*final div2 = await searchBloc.getCoorsStartToEnd(const LatLng(-17.974759,-67.108544) ,const LatLng(-21.459718,-65.705185) ,'DIV-2 200800-MAY-24 CONFIGURACION DE EQUIPOS AL COMPLETO, REVISION DE INVENTARIOS S/N- en la madrugada del 22-MAY-24 se registro la falla de un UPS, la misma levanto dos dias despues S/N');
      await mapBloc.drawRoutePolyline2(div2);
         final div10 = await searchBloc.getCoorsStartToEnd(const LatLng(-21.459718,-65.705185) 
         ,const LatLng(-21.259038,-63.472089) ,'DIV-10 230800-MAY-24-CONFIGURACION DE EQUIPOS AL COMPLETO, REVISION DE INVENTARIOS S/N');
      await mapBloc.drawRoutePolyline2(div10);
               final div3 = await searchBloc.getCoorsStartToEnd(const LatLng(-21.259038,-63.472089) 
               ,const LatLng(-20.070771,-63.497646) 
               ,'DIV-3 280800-MAY-24 CONFIGURACION DE EQUIPOS PENDIENTE se esta realizando la configuracion de un FIREWALL en laboratorios de HANSA via remota-REVISION DE INVENTARIOS S/N.');
      await mapBloc.drawRoutePolyline2(div3);
      final div4 = await searchBloc.getCoorsStartToEnd(const LatLng(-20.070771,-63.497646) 
               ,const LatLng(-17.831693,-63.171017) 
               ,'DIV-4 310800-MAY-24  INSTALACION Y ENTREGA DE UN FIREWALL EVACUADO--PRUEBAS DE TELEFONIA CON LA DIV-2 Y LA DIV-10 EXITOSAS-CONFIGURACION DE EQUIPOS AL COMPLETO-REVISION DE INVENTARIOS S/N.');
      await mapBloc.drawRoutePolyline2(div4);
            final div8 = await searchBloc.getCoorsStartToEnd(const LatLng(-17.831693,-63.171017) 
      ,const LatLng(-18.346882,-59.724561) 
      ,'DIV-8 040800-JUN-24  NO CUENTA CON CABLEADO DE INTERNET EN TELEFONIA(INSTALADO EN LA AYUDANTIA), NO CUENTA CON SERVICIO DE INTERNET(ENTEL)-- SE REALIZO EL RESTABLECIMIENTO DE SERVICIO DE INTERNET PARA LA DIV-8 Y PARA LA DIV-5 EN COORDINACION CON LA EMPRESA ENTEL, EXTENDIENDO MAS DE 100 MTS DE CABLE Y CAMBIANDO FIBRA OPTICA DANADA POR LA CAIDA DE UN ARBOL--  PRUEBAS DE TELEFONIA CON LA DIV-2 Y LA DIV-10 EXITOSAS-CONFIGURACION DE EQUIPOS AL COMPLETO-REVISION DE INVENTARIOS S/N.');
      await mapBloc.drawRoutePolyline2(div8);
    final div5 = await searchBloc.getCoorsStartToEnd(const LatLng(-18.346882,-59.724561) 
      ,const LatLng(-14.872969,-64.888371) 
      ,'DIV-5 060800-JUN-24  CABLEADO EXTERNO DE TELEFONIA INTERNA CORROIDO, SWITCH PRINCIPAL CON 6 PUERTOS QUEMADOS(2 EN REGULAR ESTADO)-NO CUENTA CON SERVICIO DE INTERNET(ENTEL)-- SE EVALUO Y DIAGNOSTICO EL CABLEADO CORROIDO ELABORANDO UN INFORME DE REPOSICION, NO SE INSTALO LA TELEFONIA INTERNA PARA PRECAUTELAR LOS EQUIPOS DE UNA POSIBLE DESCARGA ELECTRICA, SE REALIZO EL RESTABLECIMIENTO DE SERVICIO DE INTERNET EN COORDINACION CON LA EMPRESA ENTEL- PRUEBAS DE TELEFONIA CON LA DIV-2 Y LA DIV-10 EXITOSAS-CONFIGURACION DE EQUIPOS PARCIAL-REVISION DE INVENTARIOS S/N.');
      await mapBloc.drawRoutePolyline2(div5);
          final div6 = await searchBloc.getCoorsStartToEnd(const LatLng(-14.872969,-64.888371) 
      ,const LatLng(-11.089509,-68.694029) 
      ,'DIV-6 060800-JUN-24  UPS EN MAL ESTADO -- SE EVALUO Y DIAGNOSTICO EL UPS ELABORANDO UN INFORME DE REPOSICION, NO SE REALIZO PRUEBAS EN EQUIPOS PRECAUTELAR LOS EQUIPOS DE UNA POSIBLE DESCARGA ELECTRICA- PRUEBAS DE TELEFONIA CON LA DIV-2,10,4,8,5 EXITOSAS-CONFIGURACION DE EQUIPOS PARCIAL-REVISION DE INVENTARIOS S/N.');
      await mapBloc.drawRoutePolyline2(div6);*/
    /*if ( result.manual == true ) {
      searchBloc.add( OnActivateManualMarkerEvent() );
      return;
    }

    if ( result.position != null ) {
      final destination = await searchBloc.getCoorsStartToEnd( locationBloc.state.lastKnownLocation!, result.position! );
      await mapBloc.drawRoutePolyline(destination);
    }*/

  }

   

    Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Basic dialog title'),
          content: const Text(
            'A dialog is a type of modal window that\n'
            'appears in front of app content to\n'
            'provide critical information, or prompt\n'
            'for a decision to be made.',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Disable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Enable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  
}
