import 'package:flutter/material.dart';
import 'package:mercurio/models/dates.dart';
import 'package:pie_chart/pie_chart.dart';

class InicioPage extends StatelessWidget {
   InicioPage({super.key});
  final options = const ['documents'];

  
  List<Dates> datos = [
    Dates(id: '1', name: 'Radiogramas Recibidos', cifras: 958 ),
    Dates(id: '2', name: 'Radiogramas Expedidos', cifras: 1213 ),
    Dates(id: '3', name: 'Equipos de Radio Operables', cifras: 1001 ),
    Dates(id: '4', name: 'Personal de Comunicaciones que trabaja en otras actividades', cifras: 378 ),
    Dates(id: '4', name: 'Peronal de otras armas que operan la Radio', cifras: 45 ),
  ];

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parte del 17-Jun-24', style: TextStyle( color: Colors.black87 ) ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: <Widget>[

      _showGraph(),
        Text('MENU'),
          Expanded(
            
            child: ListView.builder(
              
      itemCount: options.length,
      itemBuilder: (context, i) =>ListTile(
        title: Text(options[i]),
        trailing: const Icon(Icons.arrow_forward_ios_outlined),
        onTap: (){
          Navigator.pushNamed(context, options[i]);
        },
      ) ,
            ),
          ),    

        ],
      ),

   );
    
  }
  
  
  Widget ListaMenu() {
    return ListView.separated(
      itemCount: options.length,
      itemBuilder: (context, i) =>ListTile(
        title: Text(options[i]),
        trailing: const Icon(Icons.arrow_forward_ios_outlined),
        onTap: (){
          Navigator.pushNamed(context, options[i]);
        },
      ) ,
    separatorBuilder: (_, __)=> const Divider(),
    );
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
      height: 400,
      child: PieChart(
          dataMap: dataMap,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 1,
      //chartRadius: MediaQuery.of(context).size.width / 3.2,
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: ChartType.disc,
      ringStrokeWidth: 32,
      //centerText: "HYBRID",
      legendOptions: LegendOptions(
        showLegendsInRow: true,
        legendPosition: LegendPosition.bottom,
        showLegends: true,
        legendShape: BoxShape.circle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: false,
        showChartValues: true,
        showChartValuesInPercentage: false,
        showChartValuesOutside: false,
        decimalPlaces: 0,
      ),
      // gradientList: ---To add gradient colors---
      // emptyColorGradient: ---Empty Color gradient---
      )
    );
  }
}