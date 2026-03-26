import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class ApiService {
  Future<dynamic> getWord(String word) async {
    final url = "${ApiConfig.baseUrl}/dictionary/$word";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }
}