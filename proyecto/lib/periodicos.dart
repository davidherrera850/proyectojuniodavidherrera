//Importamos los paquetes flutter necesarios y el url_launcher para abrir enlaces en el navegador
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PeriodicosPage extends StatelessWidget {
  const PeriodicosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Periódicos Deportivos',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.yellow,
        child: Center(
          //Hacemos la columna para organizar los widget
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
                  'Prensa',
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.red,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              _buildImageWithText(
                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRahFD_ra0jshp6Ae5ubqJcaKa4PyVsFv8F7hUZVUd01tDBTJ7brxd5A2IHOrUKdbk9M-A&usqp=CAU',
                text: 'Marca',
                link: 'https://www.marca.com',
              ),
              const SizedBox(height: 15),
              _buildImageWithText(
                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpNuXfLzurW6D1O0mdOty4JQQmzm6miCMeb0-2dNJ0-HOA0sm8vAseeLr01o7kwXWwy1k&usqp=CAU',
                text: 'AS',
                link: 'https://www.as.com',
              ),
              const SizedBox(height: 15),
              _buildImageWithText(
                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSs1kUKkJkUJjoH1n0KDD19NoWXsOkYqdMgKvRv2OcEBhR8fPBJJjye2qGJ0W33AOLRGQI&usqp=CAU',
                text: 'Mundo Deportivo',
                link: 'https://www.mundodeportivo.com',
              ),
              const SizedBox(height: 15),
              _buildImageWithText(
                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQSG4F32Stx6jNxQVHMbNLaPEnxODHX4HGrHnVo83wTsszg_K-EcOm-aLw3S8C-R8bUg&usqp=CAU',
                text: 'Sport',
                link: 'https://www.sport.es',
              ),
            ],
          ),
        ),
      ),
    );
  }
  //Metodo para construir un widget que combina texto e imágenes
  Widget _buildImageWithText({
    required String imageUrl,
    required String text,
    required String link,
  }) {
    return GestureDetector(
      onTap: () {
        //Abrir el enlace cuando se pulsa el widget(imagen)
        launch(link);
      },
      child: Column(
        children: [
          Image.network(
            imageUrl,
            width: 150,
            height: 100,
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}