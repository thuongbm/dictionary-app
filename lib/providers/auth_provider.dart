import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  int? _userId;
  String? _username;
  bool _isLoggedIn = false;

  int? get userId => _userId;
  String? get username => _username; // Thêm getter để hiển thị tên nếu cần
  bool get isLoggedIn => _isLoggedIn;

  final ApiService _apiService = ApiService();

  // --- HÀM ĐĂNG NHẬP ---
  Future<bool> login(String username, String password) async {
    try {
      final result = await _apiService.login(username, password);
      if (result != null && result['user_id'] != null) {
        _userId = result['user_id'];
        _username = username;
        _isLoggedIn = true;
        notifyListeners();
        return true;
      }
    } catch (e) {
      debugPrint("Login error: $e");
    }
    return false;
  }

  // --- HÀM ĐĂNG KÝ (MỚI THÊM) ---
  Future<bool> register(String username, String password) async {
    try {
      final result = await _apiService.register(username, password);
      // Dựa trên code Flask của bạn, đăng ký thành công trả về {"message": "Register success"}
      if (result != null && result['message'] == "Register success") {
        return true;
      }
    } catch (e) {
      debugPrint("Register error: $e");
    }
    return false;
  }

  void logout() {
    _userId = null;
    _username = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}