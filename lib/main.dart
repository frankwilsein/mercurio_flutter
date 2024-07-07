import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mercurio/blocs/blocs.dart';
import 'package:mercurio/blocs/search/search_bloc.dart';
import 'package:mercurio/pages/login_page.dart';
import 'package:mercurio/pages/pages.dart';

import 'package:mercurio/providers/ui_provider.dart';
import 'package:mercurio/services/services.dart';
//import 'package:mercurio/services/scans_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>UiProvider()),
        ChangeNotifierProvider(create: (_) => DocumentsService()),
        BlocProvider(create: (context) => GpsBloc() ),
        BlocProvider(create: (context) => LocationBloc()),
        BlocProvider(create: (context) => MapBloc(locationBloc: BlocProvider.of(context))), 
        BlocProvider(create : (context) => SearchBloc(trafficService: TrafficService())),

        //ChangeNotifierProvider(create: (_)=>ScansService(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MERCURIO',
        initialRoute: 'login',
        routes: {
          'home': (_)=> HomePage(),
          'inicio':(_)=>InicioPage(),
          'documents':(_)=>DocumentosPage(),
          'document':(_)=>DocumentPage(),
          'simplan':(_)=> SimplanPage(),
          'scan':(_)=>ScanPage(),
          'admin':(_)=>AdminPage(),
          'login':(_)=>LoginPage(),
      
        },
       theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: Color.fromARGB(255, 236, 224, 178),
            appBarTheme: AppBarTheme(
                elevation: 0, color: Color.fromRGBO(168, 20, 69, 0.829)),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Color.fromRGBO(168, 20, 69, 0.829),
                elevation: 0)),
      ),
    );
  }
}