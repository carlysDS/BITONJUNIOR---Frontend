import 'package:flutter/material.dart';
import '../servicios/auth_servicio.dart';

class RegistroController {
  final AuthService _authService = AuthService();

  Future<void> registrarUsuario({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required Map<String, dynamic> data,
    required String correo,
    required String correoConfirm,
    required String password,
    required String passwordConfirm,
  }) async {
    if (!formKey.currentState!.validate()) return;

    if (correo != correoConfirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Los correos no coinciden')),
      );
      return;
    }

    if (password != passwordConfirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    try {
      final response = await _authService.register(data);

      if (response['statusCode'] == 201) {
        final token = response['body']['data']['access_token'];

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registro exitoso')),
        );

        print("TOKEN: $token"); // opcional
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['body']['message'] ?? 'Error')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de conexión')),
      );
    }
  }
}