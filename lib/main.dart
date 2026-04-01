import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screens.dart';
import 'providers/translation_provider.dart';
import 'providers/dictionary_provider.dart';
import 'providers/thesaurus_provider.dart';
import 'package:flutter/services.dart'; // 1. Make sure this is imported

void main() {
  runApp(
    // 2. Use MultiProvider to host both of your providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TranslationProvider()),
        ChangeNotifierProvider(create: (_) => DictionaryProvider()),
        ChangeNotifierProvider(create: (_) => ThesaurusProvider()), // Added this
      ],
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