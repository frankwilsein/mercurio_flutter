import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:flutter/material.dart';
import 'package:mercurio/models/models.dart';

import 'package:http/http.dart' as http;

class DocumentsService extends ChangeNotifier {
  final String _baseUrl = 'mercurio-flutter-default-rtdb.firebaseio.com';
  final List<Document> documents = [];
  late Document selectedDocument;
  late Document ocr;

  File? newPictureFile;
  File? croppPicture;

  bool isLoading = true;
  bool isSaving = false;

  DocumentsService() {
    this.loadDocuments();
  }
  Future<List<Document>> loadDocuments() async {
    this.isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'documents.json');
    //final url = Uri.parse("radio-21508-default-rtdb.firebaseio.com/documents.json");
    final resp = await http.get(url);

    final Map<String, dynamic> documentsMap = json.decode(resp.body);
  //print(documentsMap);
    documentsMap.forEach((key, value) {
      final tempDocument = Document.fromMap(value);
      tempDocument.id = key;
      this.documents.add(tempDocument);
    });

   // print(this.documents[0].EMISOR);

    this.isLoading = false;
    notifyListeners();

    return this.documents;
  }

  Future saveOrCreateDocument(Document document) async {
    isSaving = true;
    notifyListeners();

    if (document.id == null) {
      await (createDocument(document));
    } else {
      await this.updateDocument(document);
    }
    isSaving = false;
    notifyListeners();
  }

  Future<String> updateDocument(Document document) async {
    final url = Uri.https(_baseUrl, 'documents/${document.id}.json');
    final resp = await http.put(url, body: document.toJson());
    final decodedData = resp.body;

    //print(decodedData);

    final index = this.documents.indexWhere((element) => element.id == document.id);
    this.documents[index] = document;

    return document.id!;
  }

  Future<String> createDocument(Document document) async {
    final url = Uri.https(_baseUrl, 'documents.json');
    final resp = await http.post(url, body: document.toJson());
    final decodedData = json.decode(resp.body);

    document.id = decodedData['name'];

    this.documents.add(document);

    return document.id!;

    //print(decodedData);.
  }

  void updateSelectedDocumentImage(String path) {
    this.selectedDocument.picture = path;
    this.newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();
  }

  Future<void> UpdateCroppImage(String path) async {

    this.selectedDocument.picture =path;

    croppPicture = File.fromUri(Uri(path:path));
    notifyListeners();
    
    final url = Uri.parse("https://ocr-rest-api.onrender.com/prueba");
    final imageUploadRequest=http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', this.croppPicture as String);

    imageUploadRequest.files.add(file);

    final response = await imageUploadRequest.send();
    final resp =await http.Response.fromStream(response);
 
  }

  Future<String?> uploadImage() async {
    if (this.newPictureFile == null) return null;

    this.isSaving = true;
    notifyListeners();

    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dw9ufcdbq/image/upload?upload_preset=jdiusvk3');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('algo salio mal');
      print(resp.body);
      return null;
    }

    this.newPictureFile = null;

    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }
    Future<Document> updateSelectedDocumentImageOCR(String path) async{
    //if (this.newPictureFile == null) return null;
    this.selectedDocument.picture = path;
    this.newPictureFile = File.fromUri(Uri(path: path));
    //upload image to APIRENDER
     final url = Uri.parse(
        'https://ocr-rest-api.onrender.com/prueba');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('algo salio mal');
      print(resp.body);
      //return null;
    }

    this.newPictureFile = null;

    final decodedData = json.decode(resp.body);
    this.ocr =decodedData;
    notifyListeners();
    return this.ocr;
  }


    Future<String?> uploadImageScan(String? path) async {
    if (path == null) return null;

    this.isSaving = true;
    notifyListeners();

    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dw9ufcdbq/image/upload?upload_preset=jdiusvk3');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file =
        await http.MultipartFile.fromPath('file', path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('algo salio mal');
      print(resp.body);
      return null;
    }

    this.newPictureFile = null;

    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }
}
