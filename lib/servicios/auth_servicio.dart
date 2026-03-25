import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final String apiUrl = 'https://tu-api.com/api/auth';

  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$apiUrl/register'),
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