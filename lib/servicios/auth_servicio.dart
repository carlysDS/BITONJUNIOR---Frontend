import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  final String apiUrl = dotenv.env['API_URL'] ?? 'http://18.100.79.40:8000/api/auth/register';

  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    print('Inicio del register');
    try{
       final url = apiUrl;
      print('🌍 URL: $url');
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',},
        body: jsonEncode(data),      
    );
    print('✅ STATUS: ${response.statusCode}');
    print('📦 BODY: ${response.body}');

    return {
      'statusCode': response.statusCode,
      'body': jsonDecode(response.body),
    };
    }catch (e) {
       print('🔥 ERROR REAL: $e');

    return {
      'statusCode': 500,
      'body': {'message': e.toString()},
  };
  }
  }
}