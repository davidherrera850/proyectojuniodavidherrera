//Importar los paquetes necesarios y las diferentes paginas de la aplicación
import 'package:flutter/material.dart';
import 'menu.dart';
import 'resultados.dart';
import 'periodicos.dart';
import 'blog.dart';
import 'tienda.dart';
import 'juego_preguntas.dart';
import 'iniciosesion.dart';
import 'arbitraje.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Título de la aplicación
      title: 'Fanaticos de la pelota',
      //Es la ruta inicial de la aplicación
      initialRoute: '/',
      //Definimos las rutas de navegación
      routes: {
        '/': (context) => const MenuPage(),
        '/resultados': (context) => const ResultadosPage(),
        '/periodicos': (context) => const PeriodicosPage(),
        '/blog': (context) => const BlogPage(),
        '/tienda': (context) => const TiendaPage(),
        '/juego_preguntas': (context) => const JuegoPreguntasPage(),
        '/iniciosesion': (context) => const InicioSesionPage(),
        '/arbitraje': (context) => ArbitrajePage(),
      },
    );
  }
}