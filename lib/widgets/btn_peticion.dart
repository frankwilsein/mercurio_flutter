import 'package:flutter/material.dart';

class BtnPeticion extends StatelessWidget {
  final IconData icon2;
  final String text;
  //final void Function;
  final dynamic onPressed2;
  const BtnPeticion({super.key, 
  required this.icon2, 
  required this.text, 
  required this.onPressed2, });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
          
        style: TextButton.styleFrom(
          
           foregroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 110, 23, 49),
        ),
        /*elevation:2,
        highlightElevation: 5,
        shape: StadiumBorder(),*/
        onPressed: onPressed2,
            icon: Icon(this.icon2),
            label: Text(this.text),

    /* child: Container(
        width: double.infinity,
        height: 35,
        child: Center(
          child: Text('Ingresar', style: TextStyle(color: Colors.white),),
          
        ),
      )*/
      );
  }
}