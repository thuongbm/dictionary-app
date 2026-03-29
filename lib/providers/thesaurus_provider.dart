import 'package:flutter/material.dart';
import '../models/thesaurus_model.dart';

class ThesaurusProvider extends ChangeNotifier {
  ThesaurusResult? _result;
  bool _isLoading = false;

  ThesaurusResult? get result => _result;
  bool get isLoading => _isLoading;

  // Added this to allow hiding the section
  void hide() {
    _result = null;
    notifyListeners();
  }

  Future<void> searchThesaurus(String query) async {
    if (query.isEmpty || query == "Hello") return;
    _isLoading = true;
    _result = null; // Clear old result while loading
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));
    _result = ThesaurusResult.mock(query);

    _isLoading = false;
    notifyListeners();
  }
}