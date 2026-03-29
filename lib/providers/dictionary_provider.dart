import 'package:flutter/material.dart';
import '../models/word_model.dart';

class DictionaryProvider extends ChangeNotifier {
  // Change WordModel? to DictionaryResult?
  DictionaryResult? _result;
  bool _isLoading = false;

  DictionaryResult? get result => _result;
  bool get isLoading => _isLoading;

  void searchWord(String query) async {
    if (query.isEmpty) return;
    
    _isLoading = true;
    notifyListeners();

    // Simulate API Call
    await Future.delayed(const Duration(seconds: 1));
    
    // Change to DictionaryResult.mock
    _result = DictionaryResult.mock(query);

    _isLoading = false;
    notifyListeners();
  }
}