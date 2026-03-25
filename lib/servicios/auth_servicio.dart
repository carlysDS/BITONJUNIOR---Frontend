import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  final String apiUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:8000/api';

  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$apiUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    //Hoooolaaa
    return {
      'statusCode': response.statusCode,
      'body': jsonDecode(response.body),
    };
  }
}