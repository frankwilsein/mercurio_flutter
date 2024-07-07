import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mercurio/models/dates.dart';
import 'package:pie_chart/pie_chart.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  List<Dates> datos = [
    Dates(id: '1', name: 'Radiogramas Recibidos', cifras: 5 ),
    Dates(id: '2', name: 'Radiogramas Expedidos', cifras: 1 ),
    Dates(id: '3', name: 'Equipos de Radio Operables', cifras: 2 ),
    Dates(id: '4', name: 'Equipos de Radio No Operables', cifras: 5 ),
    Dates(id: '4', name: 'Centros de Comunicaciones Moviles', cifras: 5 ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parte del Comando de Comunicaciones', style: TextStyle( color: Colors.black87 ) ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
    body: Column(
      children: <Widget>
      [
          _showGraph(),

          Expanded(child: ListView.builder(
        itemCount: datos.length,
        itemBuilder: ( context, i ) => _bandTile( datos[i] )
      ),)
      ],
    ),

      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.add ),
        elevation: 1,
        onPressed: addNewBand
      ),
   );
  }

  Widget _bandTile( Dates band ) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: ( direction ) {
        print('direction: $direction');
        print('id: ${ band.id }');
        // TODO: llamar el borrado en el server
      },
      background: Container(
        padding: EdgeInsets.only( left: 8.0 ),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete Band', style: TextStyle( color: Colors.white) ),
        )
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text( band.name.substring(0,2) ),
          backgroundColor: Colors.blue[100],
        ),
        title: Text( band.name ),
        trailing: Text('${ band.cifras }', style: TextStyle( fontSize: 20) ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {

    final textController = new TextEditingController();
    
    if ( Platform.isAndroid ) {
      // Android
      return showDialog(
        context: context,
        builder: ( context ) {
          return AlertDialog(
            title: Text('New band name:'),
            content: TextField(
              controller: textController,
            ),
            actions: <Widget>[
              MaterialButton(
                child: Text('Add'),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () => addBandToList( textController.text )
              )
            ],
          );
        },
      );
    }

    showCupertinoDialog(
      context: context, 
      builder: ( _ ) {
        return CupertinoAlertDialog(
          title: Text('New band name:'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Add'),
              onPressed: () => addBandToList( textController.text )
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Dismiss'),
              onPressed: () => Navigator.pop(context)
            )
          ],
        );
      }
    );

  }  

  void addBandToList( String name ) {
    print(name);

    if ( name.length > 1 ) {
      // Podemos agregar
      this.datos.add( new Dates(id: DateTime.now().toString(), name: name, cifras: 0 ) );
      setState(() {});
    }


    Navigator.pop(context);

  }

    Widget _showGraph() {

    Map<String, double> dataMap = new Map();
    // dataMap.putIfAbsent('Flutter', () => 5);
    datos.forEach((datos) {
      dataMap.putIfAbsent( datos.name, () => datos.cifras!.toDouble() );
    });

    final List<Color> colorList = [
      Color.fromRGBO(193, 160, 212, 1),
          Color.fromRGBO(243, 199, 67, 1),
      Color.fromRGBO(127, 235, 39, 1),
 Color.fromRGBO(66, 127, 240, 1),
        Color.fromRGBO(126, 251, 255, 1),
      Color.fromARGB(255, 201, 53, 8),
    ];
    return Container(
      padding: EdgeInsets.only(top: 10),
      width: double.infinity,
      height: 200,
      child: PieChart(
          dataMap: dataMap,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width / 3.2,
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: ChartType.ring,
      ringStrokeWidth: 32,
      centerText: "HYBRID",
      legendOptions: LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.right,
        showLegends: true,
        legendShape: BoxShape.circle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: false,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),
      // gradientList: ---To add gradient colors---
      // emptyColorGradient: ---Empty Color gradient---
      )
    );
  }

}