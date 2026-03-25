import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  final String apiUrl = dotenv.env['API_URL'] ?? 'http://18.100.70.40:8000/api/auth';

  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    try{
      final response = await http.post(
        Uri.parse('$apiUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
    );

    return {
      'statusCode': response.statusCode,
      'body': jsonDecode(response.body),
    };
    }catch(e){
      return{
      'statusCode': 500,
        'body': {'message': 'Error de conexión'},
      };
    }
  }
}