import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mercurio/models/document.dart';
import 'package:mercurio/models/models.dart';

class ScanFormProvider extends ChangeNotifier{
  GlobalKey<FormState> formKey=new GlobalKey<FormState>();
   File? croppPicture;

  Document document;
  
  ScanFormProvider(this.document);


   bool isValidForm(){

    print(formKey.currentState?.validate());
    return formKey.currentState?.validate() ?? false;
   }
}