import 'package:flutter/material.dart';
import '../controller/registro_controller.dart';

class RegistroPage extends StatefulWidget {
 final VoidCallback onToggleTheme;
  final bool estaModoOscuro;

  RegistroPage({
    required this.onToggleTheme,
    required this.estaModoOscuro,
    Key? key,
  }) : super(key: key);

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _formKey = GlobalKey<FormState>();
  final controller = RegistroController();
 

  final nombreCtrl = TextEditingController();
  final apellido1Ctrl = TextEditingController();
  final apellido2Ctrl = TextEditingController();
  final telefonoCtrl = TextEditingController();
  final poblacionCtrl = TextEditingController();
  final correoCtrl = TextEditingController();
  final correoConfirmCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final passwordConfirmCtrl = TextEditingController();

  bool passwordVisible = false;
  bool passwordConfirmVisible = false;

  void onSubmit() {
    final data = {
      "name": nombreCtrl.text,
      "surname_1": apellido1Ctrl.text,
      "surname_2": apellido2Ctrl.text,
      "phone_number": telefonoCtrl.text,
      "city": poblacionCtrl.text,
      "email": correoCtrl.text,
      "password": passwordCtrl.text,
    };

    controller.registrarUsuario(
      context: context,
      formKey: _formKey,
      data: data,
      correo: correoCtrl.text,
      correoConfirm: correoConfirmCtrl.text,
      password: passwordCtrl.text,
      passwordConfirm: passwordConfirmCtrl.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
        centerTitle: true,
        actions: [
          IconButton(
          icon: Icon(
          widget.estaModoOscuro ? Icons.dark_mode : Icons.light_mode,
          ),
          onPressed: widget.onToggleTheme,
        )
  ]),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: nombreCtrl, decoration: InputDecoration(labelText: 'Nombre')),
              TextFormField(controller: apellido1Ctrl, decoration: InputDecoration(labelText: 'Apellido 1')),
              TextFormField(controller: apellido2Ctrl, decoration: InputDecoration(labelText: 'Apellido 2')),
              TextFormField(controller: telefonoCtrl, decoration: InputDecoration(labelText: 'Teléfono')),
              TextFormField(controller: poblacionCtrl, decoration: InputDecoration(labelText: 'Población')),
              TextFormField(controller: correoCtrl, decoration: InputDecoration(labelText: 'Email')),
              TextFormField(controller: correoConfirmCtrl, decoration: InputDecoration(labelText: 'Confirmar Email')),
              TextFormField(controller: passwordCtrl, decoration: InputDecoration(labelText: 'Password')),
              TextFormField(controller: passwordConfirmCtrl, decoration: InputDecoration(labelText: 'Confirmar Password')),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: onSubmit,
                child: Text('Registrar'),
              )
            ],
          ),
        ),
      ),
  
  
    );
  }


  
}