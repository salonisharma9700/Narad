import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/api_response.dart';

// const String apiUrl = 'http://127.0.0.1:5000/summarize'; // Change this if needed
const String apiUrl = 'http://192.168.210.145:5000/summarize'; 


Future<ApiResponse> getSummary(String article, [String? customPrompt]) async {
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'article': article,
        'prompt': customPrompt,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return ApiResponse(summary: responseData['summary']);
    } else {
      return ApiResponse(summary: 'Failed to get summary');
    }
  } catch (e) {
    return ApiResponse(summary: 'Error: $e');
  }
}

