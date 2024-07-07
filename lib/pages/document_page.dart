import 'package:flutter/material.dart';
import 'package:mercurio/providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:mercurio/providers/scan_form_provider.dart';
import 'package:mercurio/services/services.dart';
import 'package:mercurio/ui/input_decorations.dart';
import 'package:mercurio/widgets/widgets.dart';

class DocumentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final documentService = Provider.of<DocumentsService>(context);

    return ChangeNotifierProvider(
      create: (_) => DocumentFormProvider(documentService.selectedDocument),
      child: _DocumentPageBody(documentService: documentService),
    );
    //return Scaffold();
  }
}

class _DocumentPageBody extends StatelessWidget {
  const _DocumentPageBody({
    super.key,
    required this.documentService,
  });

  final DocumentsService documentService;

  @override
  Widget build(BuildContext context) {
    final documentForm = Provider.of<DocumentFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                DocumentImage(url: documentService.selectedDocument.picture),
                Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
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
            _DocumentForm(),
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
        onPressed: documentService.isSaving
            ? null
            : () async {
                if (!documentForm.isValidForm()) return;

                final String? imageUrl = await documentService.uploadImage();

                if (imageUrl != null) documentForm.document.picture = imageUrl;

                await documentService.saveOrCreateDocument(documentForm.document);
              },
      ),
    );
  }
}

class _DocumentForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final documentForm = Provider.of<DocumentFormProvider>(context);
    final document = documentForm.document;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
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
                initialValue: document.CODIGO,
                onChanged: (value) => document.CODIGO = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'el codigo es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Codigo del documento', labeltext: 'Codigo:'),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: document.LUGARFECHA,
                //initial value:'${document.price}'
                onChanged: (value) => document.LUGARFECHA = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'es necesario la fecha y lugar';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Lugar y fecha del documento',
                    labeltext: 'Lugar y fecha:'),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: document.EMISOR,
                //initial value:'${document.price}'
                onChanged: (value) => document.EMISOR = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'es necesario un emisor';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Unidad que emite el documento',
                    labeltext: 'Unidad Emisora:'),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: document.RECEPTOR,
                //initial value:'${document.price}'
                onChanged: (value) => document.RECEPTOR = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'es necesario un emisor';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Unidad(es) receptor(es) del documento',
                    labeltext: 'Unidad(es) Receptor(es):'),
              ),
              SizedBox(height: 10),
              TextFormField(
                maxLines: 5,
                initialValue: document.CONTENIDO,
                //initial value:'${document.price}'
                onChanged: (value) => document.CONTENIDO = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'es necesario poner un contenido';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Contenido del Documento',
                    labeltext: 'Contenido del Documento:'),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: document.FIRMA,
                //initial value:'${document.price}'
                onChanged: (value) => document.FIRMA = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'es necesario que especifique quien firma el documento';
                },
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
    );
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
}
