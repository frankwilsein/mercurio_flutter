import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showDescripcion( BuildContext context,String ?descripcion ) {

  // Android
  if ( Platform.isAndroid ) {
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: ( _ ) => AlertDialog(
        title: const Text('Descripcion'),
        content: Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only( top: 10),
          child: Column(
            children: const [
            ],
          ),
        ),
      )
    );
    return;
  }

  showCupertinoDialog(
    context: context, 
    builder: ( context ) => const CupertinoAlertDialog(
      title: Text('Espere por favor'),
      content: CupertinoActivityIndicator(),
    )
  );


}