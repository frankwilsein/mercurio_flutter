import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});
  final options = const ['documents','admin'];


  @override
  Widget build(BuildContext context) {
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

/*  Widget _ShowGraph(){
    Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };
  PieChart(dataMap: dataMap) ;

  }*/
}