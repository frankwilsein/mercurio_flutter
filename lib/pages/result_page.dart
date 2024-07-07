import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mercurio/models/models.dart';
import 'package:mercurio/providers/document_form_provider.dart';
//import 'package:mercurio/providers/providers.dart';
import 'package:mercurio/services/services.dart';
import 'package:mercurio/ui/ui.dart';
import 'package:mercurio/widgets/widgets.dart';
import 'package:provider/provider.dart';



class ResultPage extends StatelessWidget {
  var data;
  
  var image;

  ResultPage({super.key, required this.data, required  this.image});


  @override

  Widget build(BuildContext context) {

    final documentService = Provider.of<DocumentsService>(context);

    return ChangeNotifierProvider(
      create: (_) => DocumentFormProvider(documentService.ocr),
      child: _DocumentScreenBody(documentService: documentService, data: this.data, image: this.image,),
         );
    //return _DocumentScreenBody(documentService: documentService);
  }

}
  class _DocumentScreenBody extends StatelessWidget{

  
   _DocumentScreenBody({
    super.key,
    required this.documentService,
    required this.data, required  this.image
  });
  final DocumentsService documentService;
    var data;  
  var image;
  @override
  Widget build(BuildContext context) {
     documentService.ocr = Document(
                  CODIGO: '',
                  LUGARFECHA: '',
                  RECEPTOR: '',
                  EMISOR: '',
                  CONTENIDO: '',
                  FIRMA: '');
        //final scanService = Provider.of<DocumentsService>(context);

    final documentForm = Provider.of<DocumentFormProvider>(context);
    //final document = documentForm.document;

 Scan scan = Scan.fromMap(data);

  String Scodigo = scan.codigo!.join(" ");
       documentService.ocr.CODIGO=  Scodigo;
        documentService.ocr.CONTENIDO= scan.contenido?.join(" ");
         documentService.ocr.EMISOR= scan.emisor?.join(" ");
          documentService.ocr.FIRMA= scan.firma?.join(" ");
           documentService.ocr.LUGARFECHA= scan.lugarfecha!.join(" ");
            documentService.ocr.RECEPTOR= scan.receptor?.join(" ");
             documentService.ocr.picture= image;
       /*var Scodigo = scan.codigo?.join(" ");
        var Scontenido = scan.contenido?.join(" ");
        var Semisor = scan.emisor?.join(" ");
        var Sfirma = scan.firma?.join(" ");
        var Slugarfecha = scan.lugarfecha?.join(" ");
        var Sreceptor = scan.receptor?.join(" ");*/
        //String url = image;
 //final scanForm = Provider.of<ScanFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                DocumentImage(url: documentService.ocr.picture),
              //DESCOMENTAR SI SE DESEA CAMBIAR LA IMAGEN DEL ESCANEADO
                Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(
                      onPressed: () => Navigator.pushNamed(context,'documents'),
                      icon: Icon(Icons.arrow_back_ios_new,
                          size: 40, color: Colors.white),
                    )),
                Positioned(
                    top: 60,
                    right: 20,
                    child: IconButton(
                      onPressed: () async {
                        final picker = new ImagePicker();
                        final XFile? pickedFile = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 100);

                        if (pickedFile == null) {
                          print('No selecciono nada');
                          return;
                        }
                        print('Tenemos Imagen ${pickedFile.path}');

                        documentService
                            .updateSelectedDocumentImage(pickedFile.path);
                      },
                      icon: Icon(Icons.camera_alt_outlined,
                          size: 40, color: Colors.white),
                    ))
              ],
            ),
            Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child:  Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: documentForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                initialValue: documentService.ocr.CODIGO,
                onChanged: (value) => documentService.ocr.CODIGO = value,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Codigo del documento', labeltext: 'Codigo:'),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: documentService.ocr.LUGARFECHA,
                //initial value:'${data.price}'
                onChanged: (value) => documentService.ocr.LUGARFECHA = value,
                
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Lugar y fecha del documento',
                    labeltext: 'Lugar y fecha:'),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: documentService.ocr.EMISOR,
                //initial value:'${scan.price}'
                onChanged: (value) => documentService.ocr.EMISOR = value,
                
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Unidad que emite el documento',
                    labeltext: 'Unidad Emisora:'),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: documentService.ocr.RECEPTOR,
                //initial value:'${scan.price}'
                onChanged: (value) => documentService.ocr.RECEPTOR = value,
                
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Unidad(es) receptor(es) del documento',
                    labeltext: 'Unidad(es) Receptor(es):'),
              ),
              SizedBox(height: 10),
              TextFormField(
                maxLines: 5,
                initialValue: documentService.ocr.CONTENIDO,
                //initial value:'${scan.price}'
                onChanged: (value) => documentService.ocr.CONTENIDO = value,
                
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Contenido del Documento',
                    labeltext: 'Contenido del Documento:'),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: documentService.ocr.FIRMA,
                //initial value:'${scan.price}'
                onChanged: (value) => documentService.ocr.FIRMA = value,
                
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Autoridad que firma el documento',
                    labeltext: 'Autoridad que firma del documento:'),
              ),
              SizedBox(
                height: 30,
              ),
      
            ],
          ),
        ),
      ),
    ),
            SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: documentService.isSaving
            ? CircularProgressIndicator(
                color: Colors.amberAccent,
              )
            : Icon(Icons.save_outlined),
        onPressed:documentService.isSaving
            ? null
            : () async {
                if (!documentForm.isValidForm()) return;

                final String? imageUrl = await documentService.uploadImageScan(documentService.ocr.picture);

                if (imageUrl != null) documentForm.document.picture = imageUrl;

                await documentService.saveOrCreateDocument(documentForm.document);
              },
      ),
    );
  }
}



      BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]);