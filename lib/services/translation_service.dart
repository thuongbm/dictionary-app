import 'package:flutter/foundation.dart';
import '../models/translation_result.dart';
import '../models/translation_history.dart'; // THÊM IMPORT NÀY ĐỂ NHẬN DIỆN MODEL LỊCH SỬ
import 'api_service.dart';

class TranslationService {
  final ApiService _apiService = ApiService(); 

  // --- Hàm dịch (Giữ nguyên của bạn) ---
  Future<TranslationResult?> translate(
    String text, 
    String sourceLang, 
    String targetLang,
    {int? userId} 
  ) async {
    try {
      final body = {
        'text': text,
        'source_lang': sourceLang,
        'target_lang': targetLang,
        'user_id': userId, 
        'session_id': userId == null ? 'user_001' : null, 
      };

      final data = await _apiService.postRequest('/translate', body);

      if (data != null) {
        return TranslationResult.fromJson(data);
      }
      return null;
    } catch (e) {
      debugPrint("Translation Error: $e"); 
      return null;
    }
  }

  // --- HÀM MỚI BỔ SUNG ĐỂ FIX LỖI ĐỎ BÊN PROVIDER ---
  Future<List<TranslationHistory>?> getUserHistory(int userId) async {
    try {
      // Gọi API lấy lịch sử từ Flask
      final data = await _apiService.fetchHistory(userId: userId);
      
      // Nếu có dữ liệu, chuyển JSON thành List<TranslationHistory>
      if (data.isNotEmpty) {
        return data.map((json) => TranslationHistory(
          origin: json['source_text'] ?? "",
          translated: json['translated_text'] ?? "",
          // Đổi ngược mã ngôn ngữ (vi, en) thành dạng hiển thị
          fromLang: json['source_lang'] == 'vi' ? 'Tiếng Việt' : 'English',
          toLang: json['target_lang'] == 'en' ? 'English' : 'Tiếng Việt',
          sourceAudio: json['source_audio'] ?? "",
          targetAudio: json['target_audio'] ?? "",
        )).toList();
      }
      return []; // Trả về mảng rỗng nếu chưa có lịch sử
    } catch (e) {
      debugPrint("Lỗi Get History: $e");
      return null;
    }
  }
}