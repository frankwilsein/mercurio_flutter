import 'package:flutter/material.dart';

class InputDecorations{
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labeltext,
    IconData? prefixIcon
  }){
    return InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 231, 176, 10)
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color.fromARGB(117, 255, 10, 141),
                    width: 2
                  )
                ),
                hintText: hintText,
                labelText: labeltext,
                labelStyle: TextStyle(
                  color: Colors.grey
                ),
                prefixIcon : prefixIcon != null
                ? Icon(prefixIcon, color: Colors.pinkAccent)
                  :null
                );
  }
  
}