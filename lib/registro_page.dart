import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nombreCtrl = TextEditingController();
  final TextEditingController apellido1Ctrl = TextEditingController();
  final TextEditingController apellido2Ctrl = TextEditingController();
  final TextEditingController telefonoCtrl = TextEditingController();
  final TextEditingController poblacionCtrl = TextEditingController();
  final TextEditingController correoCtrl = TextEditingController();
  final TextEditingController correoConfirmCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController passwordConfirmCtrl = TextEditingController();

  bool passwordVisible = false;
  bool passwordConfirmVisible = false;

  //CAMBIAAAAAAAAAAAAAAAAAAAAAAAAAR
  final String apiUrl = 'https://tu-api.com/api/auth'; // Cambia por tu URL real

  Future<void> registrarUsuario() async {
    if (!_formKey.currentState!.validate()) return;

    if (correoCtrl.text != correoConfirmCtrl.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Los correos no coinciden')));
      return;
    }
    if (passwordCtrl.text != passwordConfirmCtrl.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Las contraseñas no coinciden')));
      return;
    }

    final Map<String, dynamic> data = {
      "name": nombreCtrl.text,
      "surname_1": apellido1Ctrl.text,
      "surname_2": apellido2Ctrl.text,
      "phone_number": telefonoCtrl.text,
      "city": poblacionCtrl.text,
      "email": correoCtrl.text,
      "password": passwordCtrl.text,
    };

    try {
      final response = await http.post(
        Uri.parse('$apiUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);
        final token = body['data']['access_token'];
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registro exitoso. Token: $token')));
        // Aquí podrías guardar el token y redirigir a otra pantalla
      } else {
        final body = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Error: ${body['message'] ?? 'Error desconocido'}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error de conexión')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro Sesión'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: nombreCtrl,
                      decoration: InputDecoration(labelText: 'Nombre'),
                      validator: (v) => v!.isEmpty ? 'Obligatorio' : null,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: apellido1Ctrl,
                      decoration: InputDecoration(labelText: 'Apellido 1'),
                      validator: (v) => v!.isEmpty ? 'Obligatorio' : null,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: apellido2Ctrl,
                      decoration: InputDecoration(labelText: 'Apellido 2'),
                      validator: (v) => v!.isEmpty ? 'Obligatorio' : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: telefonoCtrl,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(labelText: 'N° Teléfono'),
                      validator: (v) => v!.isEmpty ? 'Obligatorio' : null,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: poblacionCtrl,
                      decoration: InputDecoration(labelText: 'Población'),
                      validator: (v) => v!.isEmpty ? 'Obligatorio' : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: correoCtrl,
                decoration: InputDecoration(labelText: 'Correo Electrónico'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Obligatorio';
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(v)) return 'Email inválido';
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: correoConfirmCtrl,
                decoration: InputDecoration(labelText: 'Confirmar Correo Electrónico'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Obligatorio';
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: passwordCtrl,
                obscureText: !passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Obligatorio';
                  if (v.length != 9) return 'Debe tener 9 caracteres';
                  final alnumRegex = RegExp(r'^[a-zA-Z0-9]+$');
                  if (!alnumRegex.hasMatch(v)) return 'Solo alfanuméricos';
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: passwordConfirmCtrl,
                obscureText: !passwordConfirmVisible,
                decoration: InputDecoration(
                  labelText: 'Repetir contraseña',
                  suffixIcon: IconButton(
                    icon: Icon(passwordConfirmVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        passwordConfirmVisible = !passwordConfirmVisible;
                      });
                    },
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Obligatorio';
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: registrarUsuario,
                child: Text('Validar'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 40),
                  backgroundColor: Colors.green[400],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}