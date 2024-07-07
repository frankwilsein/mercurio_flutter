import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mercurio/models/document.dart';

import 'package:http/http.dart' as http;


class ScansService extends ChangeNotifier {
  final String _baseUrl='https://ocr-rest-api.onrender.com/prueba';
  late Document selectedScan;
  File? croppPicture;


 bool isLoading = true;
  bool isSaving = false;
  ScansService(){
      }
  
  void CreateDocument(scan){

  }

  void updateSelectedDocumentImageOCR(String path){
    this.selectedScan.picture=path;
    this.croppPicture =File.fromUri(Uri(path: path));
}
  Future<void> UpdateCroppImage(String path) async {

    this.selectedScan.picture =path;

    croppPicture = File.fromUri(Uri(path:path));
    notifyListeners();
    
    final url = Uri.parse("https://ocr-rest-api.onrender.com/prueba");
    final imageUploadRequest=http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', this.croppPicture as String);

    imageUploadRequest.files.add(file);

    final response = await imageUploadRequest.send();
    final resp =await http.Response.fromStream(response);
 
  }

}