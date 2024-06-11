//Importamos los paquetes necesarios
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'blog.dart';

class InicioSesionPage extends StatefulWidget {
  const InicioSesionPage({Key? key}) : super(key: key);

  @override
  _InicioSesionPageState createState() => _InicioSesionPageState();
}
//Controladores para los campos de usuario, clave y correo electrónico
class _InicioSesionPageState extends State<InicioSesionPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _claveController = TextEditingController();
  final TextEditingController _emailController = TextEditingController(); 
  late SharedPreferences _prefs;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }
  //Inicializacion de preferencias compartidas
  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = _prefs.getBool('isLoggedIn') ?? false;
      if (_isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BlogPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Inicio de Sesión'),
        centerTitle: true,
      ),
      backgroundColor: Colors.yellow,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: _buildLoginWidget(),
      ),
    );
  }
  //Construir el widget de inicio de sesion
  Widget _buildLoginWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRX-qpWv8_xMBydH97MP-M5mnYLe_d5rHj4cw&s',
          height: 100,
        ),
        const SizedBox(height: 20),
        const Text(
          'Inicio de Sesión Blog',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Inicia sesión para entrar al blog, ver las entradas y poder comentar o dar me gusta. Se recomienda ver los términos de la política de privacidad puestos en el apartado de la tienda',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 40),
        TextField(
          controller: _userController,
          decoration: const InputDecoration(
            labelText: 'Usuario',
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _claveController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Clave',
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'Correo Electrónico (Gmail)',
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _login,
          child: const Text('Iniciar Sesión'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => _showRegisterDialog(),
          child: const Text('Registrarse'),
        ),
      ],
    );
  }
  //Funcion para manejar el inicio de sesion
  void _login() {
    final String usuario = _userController.text.trim();
    final String clave = _claveController.text.trim();
    final String email = _emailController.text.trim().toLowerCase();

    // Validación de correo electrónico de Gmail
    if (!email.endsWith('@gmail.com')) {
      _showErrorDialog('Por favor, utiliza un correo electrónico de Gmail válido.');
      return;
    }
    //Obtener los datos almacenados previamente
    String? storedUsuario = _prefs.getString('usuario');
    String? storedClave = _prefs.getString('clave');
    String? storedEmail = _prefs.getString('email');
    //Comparar los datos introducidos con los almacenados
    if (usuario == storedUsuario && clave == storedClave && email == storedEmail) {
      _prefs.setBool('isLoggedIn', true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BlogPage()),
      );
    } else {
      _showErrorDialog('Usuario, clave o correo electrónico incorrectos.');
    }
  }
  //Función para registrar un nuevo usuario
  void _register(String usuario, String clave, String email) {
    if (usuario.isNotEmpty && clave.isNotEmpty && email.isNotEmpty && email.endsWith('@gmail.com')) {
      _prefs.setString('usuario', usuario);
      _prefs.setString('clave', clave);
      _prefs.setString('email', email);
      _showSuccessDialog('Usuario registrado exitosamente.');
      _userController.clear();
      _claveController.clear();
      _emailController.clear();
    } else if (email.isNotEmpty && !email.endsWith('@gmail.com')) {
      _showErrorDialog('Por favor, utiliza un correo electrónico de Gmail válido.');
    } else {
      _showErrorDialog('Por favor, completa todos los campos y utiliza un correo electrónico de Gmail válido.');
    }
  }

  bool _acceptPrivacyPolicy = false; // Variable para controlar si se acepta la política de privacidad

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Éxito'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  //Funcion para mostrar el dialogo de registro
  void _showRegisterDialog() {
    _userController.clear();
    _claveController.clear();
    _emailController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Registro'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: _userController,
                    decoration: const InputDecoration(
                      labelText: 'Usuario',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _claveController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Clave',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Correo Electrónico (Gmail)',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: _acceptPrivacyPolicy,
                        onChanged: (bool? value) {
                          setState(() {
                            _acceptPrivacyPolicy = value ?? false;
                          });
                        },
                      ),
                      const Text('Acepto la política de privacidad'),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    String usuario = _userController.text.trim();
                    String clave = _claveController.text.trim();
                    String email = _emailController.text.trim().toLowerCase();

                    // Validar correo electrónico de Gmail y aceptación de política de privacidad antes de registrar
                    if (usuario.isNotEmpty && clave.isNotEmpty && email.isNotEmpty && email.endsWith('@gmail.com') && _acceptPrivacyPolicy) {
                      _register(usuario, clave, email);
                      Navigator.of(context).pop(); // Cerrar el diálogo de registro
                      setState(() {
                        _acceptPrivacyPolicy = false; // Reiniciar el estado del checkbox
                      });
                    } else if (email.isNotEmpty && !email.endsWith('@gmail.com')) {
                      _showErrorDialog('Por favor, utiliza un correo electrónico de Gmail válido.');
                    } else {
                      _showErrorDialog('Por favor, completa todos los campos y acepta la política de privacidad.');
                    }
                  },
                  child: const Text('Registrarse'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

















