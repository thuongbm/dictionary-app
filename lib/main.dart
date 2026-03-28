import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 1. Added this import

// 2. Make sure these imports match your actual folder names
import 'screens/home_screens.dart'; 
import 'providers/translation_provider.dart'; 

void main() {
  runApp(
    // 3. Wrap your app in the Provider here
    ChangeNotifierProvider(
      create: (context) => TranslationProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'N3Dictionary',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: HomeScreen(), 
    );
  }
}