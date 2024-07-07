import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mercurio/services/scans_service.dart';
import 'package:provider/provider.dart';

class Scanbutton extends StatelessWidget {
  const Scanbutton({super.key});


  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.filter_center_focus),
      onPressed: () async{
                /*scansService.selectedScan = Scan(
                                  available: false,
                                  CODIGO: '',
                                  LUGARFECHA: '',
                                  RECEPTOR: '',
                                  EMISOR: '',
                                  CONTENIDO: '',
                                  FIRMA: '');*/
                              Navigator.pushNamed(context, 'scan');
                                    
                      },
    );
  }
}