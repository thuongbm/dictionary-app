import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// --- Screens ---
import 'screens/home_screens.dart';
import 'screens/auth_screen.dart'; 

// --- Providers ---
import 'providers/translation_provider.dart';
import 'providers/dictionary_provider.dart';
import 'providers/thesaurus_provider.dart';
import 'providers/auth_provider.dart'; 

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()), 
        ChangeNotifierProvider(create: (_) => TranslationProvider()),
        ChangeNotifierProvider(create: (_) => DictionaryProvider()),
        ChangeNotifierProvider(create: (_) => ThesaurusProvider()),
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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      
      // --- CẬP NHẬT: Trang chủ (/) giờ là HomeScreen ---
      initialRoute: '/', 
      routes: {
        '/': (context) => const HomeScreen(),       // Guest mode: Vào thẳng đây
        '/login': (context) => const AuthScreen(),  // Trang login được chuyển ra route riêng
      },
    );
  }
}