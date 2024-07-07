import 'package:flutter/material.dart';
import 'package:mercurio/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    
    final uiProvider=Provider.of<UiProvider>(context);
    
    final currentIndex = uiProvider.selectedMenuOpt;
    
    return BottomNavigationBar(
      onTap: (int i) =>uiProvider.selectedMenuOpt =i,
      currentIndex: currentIndex,
      elevation: 0,
      items:const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
        icon: Icon(Icons.house),
        label:'Inicio'
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.map),
        label:'Mapas'
        ),
        ],
        );
      }
}