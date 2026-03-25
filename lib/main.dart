import 'package:flutter/material.dart';
import 'views/registro_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String apiUrl = String.fromEnvironment('API_URL', defaultValue: 'http://18.100.70.40:8000/api/auth/register');


Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: RegistroPage(
        onToggleTheme: toggleTheme,
        estaModoOscuro: isDarkMode,
      ),
    );
  }
}