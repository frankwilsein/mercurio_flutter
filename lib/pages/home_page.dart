import 'package:flutter/material.dart';
import 'package:mercurio/pages/pages.dart';
import 'package:mercurio/providers/ui_provider.dart';
import 'package:mercurio/widgets/custom_navigatorbar.dart';
import 'package:mercurio/widgets/scan_button.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MERCURIO'),
         centerTitle: true, 
      )
      ,
      body:
      _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: Scanbutton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    ); 
  }
}

class _HomePageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //Text('hola prueba');
    final uiProvider= Provider.of<UiProvider>(context);
      final currentIndex = uiProvider.selectedMenuOpt;

    switch (currentIndex) {
      case 0:
        return InicioPage();
      case 1:
        return SimplanPage();
      default:
      return InicioPage();
    }
  }
}