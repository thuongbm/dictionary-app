import 'package:flutter/material.dart';
import '../models/thesaurus_model.dart';
import '../services/api_service.dart';

class ThesaurusProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  ThesaurusResult? _result;
  bool _isLoading = false;

  ThesaurusResult? get result => _result;
  bool get isLoading => _isLoading;

  Future<void> searchThesaurus(String query) async {
    if (query.isEmpty) return;

    _isLoading = true;
    _result = null; 
    notifyListeners();

    try {
      final data = await _apiService.getRequest('/thesaurus/$query');

      if (data != null) {
        // Kiểm tra xem data có chứa thông báo lỗi không
        if (data.containsKey('message') && data['message'] == 'Word not found') {
           _result = ThesaurusResult(word: query, synonyms: [], antonyms: [], relatedPhrases: []);
        } else {
           _result = ThesaurusResult.fromJson(data);
        }
      }
    } catch (e) {
      debugPrint("Thesaurus Provider Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}