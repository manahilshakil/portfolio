import 'package:flutter/material.dart';
import 'package:portfolio/screens/home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'providers/gemini_provider.dart';

const apiKey = 'AIzaSyC3XMBl2g3PwqqNw7RFsKWODSPvEBljjDA';
void main() {
  /// Initialize Gemini
  Gemini.init(apiKey: apiKey);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GeminiProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

