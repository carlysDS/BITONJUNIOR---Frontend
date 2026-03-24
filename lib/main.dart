import 'package:flutter/material.dart';
import 'registro_page.dart';  // Importa la pantalla de registro

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // QUITAR LA ETIQUETA "DEBUG"
      debugShowCheckedModeBanner: false,
      title: 'Tu App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: RegistroPage(),  // Ponemos la pantalla de registro como inicio
    );
  }
}