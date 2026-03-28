import 'package:flutter/material.dart';
import '../services/translation_service.dart';
import '../models/translation_result.dart';

class TranslationProvider extends ChangeNotifier {
  final TranslationService _service = TranslationService();

  String _resultText = "Hello";
  bool _isLoading = false;

  String get resultText => _resultText;
  bool get isLoading => _isLoading;

  Future<void> handleTranslation(String input) async {
    if (input.isEmpty) return;

    _isLoading = true;
    notifyListeners(); // Tell the UI: "Show the loading spinner!"

    try {
      final result = await _service.translate(input, "en");
      _resultText = result.translatedText;
    } catch (e) {
      _resultText = "Error: $e";
    } finally {
      _isLoading = false;
      notifyListeners(); // Tell the UI: "Stop the spinner, I have the data!"
    }
  }
}