import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/translation_result.dart';

class TranslationService {
  final String baseUrl = "https://api.yourbackend.com"; 

  Future<TranslationResult> translate(String text, String target) async {
    // --- FOR TESTING: Faking a backend delay ---
    await Future.delayed(const Duration(seconds: 1)); 
    
    try {
      // Uncomment this when your backend is ready:
      /*
      final response = await http.post(
        Uri.parse('$baseUrl/translate'),
        body: jsonEncode({'text': text, 'target': target}),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return TranslationResult.fromJson(jsonDecode(response.body));
      }
      */
      
      // Returning "Fake" data for now so your UI works immediately
      return TranslationResult(
        translatedText: "Translated: $text",
        sourceLanguage: "Vietnamese",
        targetLanguage: "English",
      );
    } catch (e) {
      throw Exception("Connection Failed: $e");
    }
  }
}