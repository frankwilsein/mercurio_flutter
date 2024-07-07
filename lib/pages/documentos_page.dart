import 'package:flutter/material.dart';
import 'package:mercurio/models/models.dart';
import 'package:mercurio/services/services.dart';
import 'package:mercurio/widgets/widgets.dart';
import 'package:provider/provider.dart';

class DocumentosPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
        final documentsService = Provider.of<DocumentsService>(context);

 return Scaffold(
        appBar: AppBar(
          title: Text('Documentos'),
          automaticallyImplyLeading: true,
        ),
        body: ListView.builder(
            itemCount: documentsService.documents.length,
            itemBuilder: (BuildContext context, int index) => GestureDetector(
                  onTap: () {
                    documentsService.selectedDocument =
                        documentsService.documents[index].copy();
                    Navigator.pushNamed(context, 'document');
                  },
                  child: ScanCard(
                    scan: documentsService.documents[index],
                  ),
                )),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              documentsService.selectedDocument = Document(
                  //available: false,
                  CODIGO: '',
                  LUGARFECHA: '',
                  RECEPTOR: '',
                  EMISOR: '',
                  CONTENIDO: '',
                  FIRMA: '');
              Navigator.pushNamed(context, 'document');
            },
          ),
        ]));
 
 
  }
}