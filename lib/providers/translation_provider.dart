import 'package:flutter/material.dart';
import '../services/translation_service.dart';
// Note: You don't actually need models/translation_result.dart imported here 
// unless you are explicitly defining it, but it's fine if it's there.

class TranslationProvider extends ChangeNotifier {
  final TranslationService _service = TranslationService();

  String _resultText = "";
  bool _isLoading = false;
  
  // State variables
  String _sourceLanguage = "Tiếng Việt";
  String _targetLanguage = "English";

  String get resultText => _resultText;
  bool get isLoading => _isLoading;
  String get sourceLanguage => _sourceLanguage;
  String get targetLanguage => _targetLanguage;

  // Logic to swap languages AND text
  void swapLanguages(TextEditingController controller) {
    final temp = _sourceLanguage;
    _sourceLanguage = _targetLanguage;
    _targetLanguage = temp;

    if (_resultText.isNotEmpty && !_resultText.startsWith("Error:")) {
      String cleanText = _resultText.replaceAll("Translated: ", "");
      controller.text = cleanText;
      _resultText = ""; 
    }

    notifyListeners();
  }

  Future<void> handleTranslation(String input) async {
    if (input.isEmpty) return;
    _isLoading = true;
    notifyListeners();

    try {
      // Pass the actual target language code to the service
      final langCode = _targetLanguage == "English" ? "en" : "vi";
      final result = await _service.translate(input, langCode);
      _resultText = result.translatedText;
    } catch (e) {
      _resultText = "Error: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}