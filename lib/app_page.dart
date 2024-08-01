import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppPage extends StatelessWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/');

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Gestor de Campanhas de Desconto',
      routerConfig: Modular.routerConfig,
      theme: ThemeData(
        primaryColor: Color(0xFF007FBA),
        indicatorColor: Color(0xFF007FBA),
        inputDecorationTheme: const InputDecorationTheme(
         
          focusedBorder: OutlineInputBorder(
            
                borderSide: BorderSide(
                    color: Colors.blue, style: BorderStyle.solid)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xFFDEDEDE), style: BorderStyle.solid)),
            border: OutlineInputBorder()),
      ),
    );
  }
}
