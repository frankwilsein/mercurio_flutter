import 'package:flutter/material.dart';
import 'package:mercurio/models/document.dart';
//import 'package:mercurio/models/models.dart';

class DocumentFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Document document;

  DocumentFormProvider(this.
  document);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}