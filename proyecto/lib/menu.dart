//Importamos los paquetes flutter necesarios
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Menú lateral que contiene las diferentes páginas
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              //Contenedor que almacena la imagen que sale en el menú
              Container(
                width: 200,
                height: 200,
                margin: const EdgeInsets.only(top: 50, bottom: 20),
                child: Image.network(
                    "https://imagenes.muyinteresante.com/files/vertical_image_670/uploads/2022/11/19/637902d7c08c5.jpeg"),
              ),
              const Text("Menú",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  //Esta es la opción de navegación para ir a la pagina indicada. Por ejemplo en este caso a resultados
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/resultados');
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  color: Colors.red,
                  child: const Text(
                    "Resultados",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/periodicos');
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 2),
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  color: Colors.red,
                  child: const Text(
                    "Periódicos",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/arbitraje');
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 2),
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  color: Colors.red,
                  child: const Text(
                    "Arbitraje",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/tienda');
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 2),
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  color: Colors.red,
                  child: const Text(
                    "Tienda",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/juego_preguntas');
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 2),
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  color: Colors.red,
                  child: const Text(
                    "Juego preguntas",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/iniciosesion');
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 2),
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  color: Colors.red,
                  child: const Text(
                    "Blog",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Fanaticos de la pelota',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.yellow,
      //Stack para superponer el texto en la imagen
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCfkbdEW4CaJHuzYe5DaF10g_ezJ0RjCuPnWRwGHe2gDwbNNqLnXcdXOY6lP7rggWeyCg&usqp=CAU'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Text(
              'Pasión Futbolera',
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                backgroundColor: Colors.black45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}