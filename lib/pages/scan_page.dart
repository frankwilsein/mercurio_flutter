import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mercurio/helpers/show_loading_message.dart';
import 'package:mercurio/pages/result_page.dart';


class ScanPage extends StatefulWidget {
 // final String title;

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  XFile? _pickedFile;
  CroppedFile? _croppedFile;
      var data;

  //get data => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !kIsWeb ? AppBar(title: Text("Mercurio")) : null,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (kIsWeb)
            Padding(
              padding: const EdgeInsets.all(kIsWeb ? 24.0 : 16.0),
              child: Text(
                "Mercurio",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Theme.of(context).highlightColor),
              ),
            ),
          Expanded(child: _body()),
        ],
      ),
    );
  }


  Widget _body() {
    if (_croppedFile != null || _pickedFile != null) {
      return _imageCard();
    } else {
      return _uploaderCard();
    }
  }
  Widget _imageCard() {
    var data;
    //String image;
    return Center(
      child: Column(
       mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kIsWeb ? 24.0 : 16.0),
                  child: Column(
              children: [Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(kIsWeb ? 24.0 : 16.0),
                  child: _image(),
            
                ),
              ),
                    ElevatedButton(
                    child :const SizedBox(
                      width: double.infinity,
                      child: Center(child:  Text('Extraer Texto'))
                    ),
                    onPressed: () async {
                        showLoadingMessage(context); 
                         if (_croppedFile == null){
                                  
                      data= await uploadImage(_pickedFile!.path);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ResultPage(
                          data:data,image: _pickedFile!.path,
                      )));
                         }
                  else{                                           
                        showLoadingMessage(context); 
                          
                      //uploadImage(_croppedFile!.path);
                       data=await uploadImage(_croppedFile!.path);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ResultPage(
                          data:data, image: _croppedFile!.path,)));
                  }                      
                    },
                  )
              ]
              ),
            ),
          ),
          const SizedBox(height: 24.0),
              _menu()
          
        ],
      ),
    );
  }

  Widget _image() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (_croppedFile != null) {
      final path = _croppedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: kIsWeb ? Image.network(path) : Image.file(File(path)),
      );
    } else if (_pickedFile != null) {
      final path = _pickedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: kIsWeb ? Image.network(path) : Image.file(File(path)),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _menu() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: () {
            _clear();
          },
          backgroundColor: Colors.redAccent,
          tooltip: 'Borrar',
          child: const Icon(Icons.delete),
        ),
        if (_croppedFile == null)
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: FloatingActionButton(
              onPressed: () {
                _cropImage();
              },
              backgroundColor: const Color(0xFFBC764A),
              tooltip: 'Crop',
              child: const Icon(Icons.crop),
            ),
          )
      ],
    );
  }

  Widget _uploaderCard() {
    return Center(
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SizedBox(
          width: kIsWeb ? 380.0 : 320.0,
          height: 300.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DottedBorder(
                    radius: const Radius.circular(12.0),
                    borderType: BorderType.RRect,
                    dashPattern: const [8, 4],
                    color: Theme.of(context).highlightColor.withOpacity(0.4),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            color: Theme.of(context).highlightColor,
                            size: 80.0,
                          ),
                          const SizedBox(height: 24.0),
                          Text(
                            'Toma una imagen para comenzar',
                            style: kIsWeb
                                ? Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                        color: Theme.of(context).highlightColor)
                                : Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color:
                                            Theme.of(context).highlightColor),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: ElevatedButton(
                  onPressed: () {
                    _uploadImage();
                  },
                  style:
                      ElevatedButton.styleFrom(foregroundColor: Color.fromARGB(255, 94, 7, 7)),
                  child: const Text('Tomar una Imagen'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _cropImage() async {
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Recorte SOLO la parte de la imagen de la que desee extraer su texto',
              toolbarColor: Color.fromARGB(255, 118, 10, 6),
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Recorte la imagen que desee extraer el texto',
          ),

        ],
        
      );
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
          print('contenido cropped=" ${_croppedFile?.path}');
        });
      }
    }
  }

  Future<void> _uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }

  void _clear() {
    setState(() {
      _pickedFile = null;
      _croppedFile = null;
    });
  }

    Future<Map<String,dynamic>> uploadImage(String  path) async {

    var request  = http.MultipartRequest(
      "POST",Uri.parse("https://ocr-rest-api.onrender.com/prueba"));

      //var picture =http.MultipartFile.fromBytes('image', (await rootBundle.load(path)).buffer.asUint8List(path.filename)); 
     final picture = await http.MultipartFile.fromPath('file', path as String);

      request.files.add(picture);

      final response =await request.send();
      final resp =await http.Response.fromStream(response);
          final decodedData = jsonDecode(resp.body);   
                if (kDebugMode) {
                  print(decodedData);
                }
      
      return decodedData;
  } 
}