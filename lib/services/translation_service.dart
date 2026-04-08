// lib/services/translation_service.dart
import '../models/translation_result.dart';
import 'api_service.dart';

class TranslationService {
  final ApiService _apiService = ApiService(); 

  // ADD: 'String target' to the arguments here
  Future<TranslationResult?> translate(String text, String target) async {
    try {
      final body = {
        'text': text,
        'target': target, // Now sending 'en' or 'vi'
        'session_id': 'user_001', 
      };

      final data = await _apiService.postRequest('/translate', body);

      if (data != null) {
        return TranslationResult.fromJson(data);
      }
      return null;
    } catch (e) {
      print("Translation Error: $e");
      return null;
    }
  }
}