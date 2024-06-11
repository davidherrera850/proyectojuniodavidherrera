import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tienda App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: TiendaPage(),
    );
  }
}

class TiendaPage extends StatelessWidget {
  const TiendaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Tienda',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.policy),
            onPressed: () {
              _showPrivacyPolicyDialog(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.yellow,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Mostrar imagen que tenemos guardada en la carpeta assets
            Image.asset(
              'assets/deportes_mango.png',
              height: 600,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Llamamos a la función cuando se pulsa el botón
                _showTable(context);
              },
              child: Text('Ver artículos'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _launchMaps,
              child: Text('Abrir en Google Maps'),
            ),
          ],
        ),
      ),
    );
  }

  // Muestra un diálogo con una tabla con los artículos
  void _showTable(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Table(
                columnWidths: {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                },
                children: [
                  _buildTableRow(
                    // Fila de la tabla con el nombre de los artículos y el precio
                    'Equipaciones equipos españoles',
                    '20€',
                  ),
                  _buildTableRow(
                    'Chándal equipos españoles',
                    '40€',
                  ),
                  _buildTableRow(
                    'Bufandas equipos españoles',
                    '15€',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Construimos una fila de la tabla con 2 columnas
  TableRow _buildTableRow(String itemName, String price) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(itemName, style: TextStyle(fontSize: 16)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(price, style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }

  // Función para abrir Google Maps
  void _launchMaps() async {
    const url = 'https://maps.app.goo.gl/yKZ7v7Qu2UFcpby99';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir $url';
    }
  }

  // Muestra un diálogo con la política de privacidad
  void _showPrivacyPolicyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Política de Privacidad'),
          content: SingleChildScrollView(
            child: Text(
              'Esta aplicación respeta y protege la privacidad de todos sus usuarios. A continuación, se detalla cómo recogemos, utilizamos y protegemos la información que nos proporcionas.\n\n' +
              '1. **Información recogida:**\n' +
              'Recopilamos información personal que nos proporcionas directamente, como tu nombre, dirección de correo electrónico y otros datos de contacto cuando te registras o interactúas con nuestra aplicación.\n\n' +
              '2. **Uso de la información:**\n' +
              'Utilizamos la información recogida para gestionar tu cuenta, procesar tus pedidos y mejorar nuestros servicios. También podemos utilizar tu información para enviarte comunicaciones comerciales relacionadas con nuestros productos y servicios, siempre que hayas dado tu consentimiento.\n\n' +
              '3. **Protección de la información:**\n' +
              'Implementamos medidas de seguridad adecuadas para proteger tu información personal contra accesos no autorizados, alteraciones, divulgaciones o destrucciones no autorizadas.\n\n' +
              '4. **Divulgación de información:**\n' +
              'No compartimos tu información personal con terceros fuera de nuestra organización, excepto cuando sea necesario para cumplir con la ley o proteger nuestros derechos.\n\n' +
              '5. **Tus derechos:**\n' +
              'Tienes derecho a acceder, corregir o eliminar tu información personal en cualquier momento. También puedes retirar tu consentimiento para el tratamiento de tu información personal.\n\n' +
              '6. **Cambios en la política:**\n' +
              'Nos reservamos el derecho de actualizar o modificar esta Política de Privacidad en cualquier momento. Te notificaremos sobre cambios significativos mediante la publicación de la versión actualizada en nuestra aplicación.\n\n' +
              'Si tienes preguntas o inquietudes sobre nuestra Política de Privacidad, por favor contáctanos a través de [deporteselmango@gmail.com].\n\n' +
              'Al utilizar nuestra aplicación, aceptas los términos de esta Política de Privacidad. Gracias por confiar en nosotros.',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}


