//Importamos los paquetes necesarios
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'iniciosesion.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  //Lista de entradas del blog
  List<Map<String, dynamic>> blogEntries = [
    {
      'title': 'Bienvenidos al blog de David el Mango',
      'content': 'Aquí hablaremos sobre todo lo relacionado a la tienda, de las mejoras de la app y de las convocatorias que saque la RFEF para ser arbitros.',
      'likes': 0,
      'comments': <Map<String, String>>[],
    },
    {
      'title': 'Deportes el Mango',
      'content': 'Nuestra tienda ya cuenta con equipaciones, chandal y bufandas de nuestros equipos de la Liga Española',
      'likes': 0,
      'comments': <Map<String, String>>[],
    },
    {
      'title': 'Deportes el Mango',
      'content': 'Nuestra tienda ya cuenta con pedido por correo no dude en contactar con nosotros a través del email o teléfono solo pedidos nacionales',
      'likes': 0,
      'comments': <Map<String, String>>[],
    },
    {
      'title': 'Deportes el Mango',
      'content': 'Nuestra tienda pronto tendrá para hacer pedidos online',
      'likes': 0,
      'comments': <Map<String, String>>[],
    },
    {
      'title': 'Mejora app',
      'content': 'Pronto tendremos un nuevo apartado en nuestra app estate atento al blog',
      'likes': 0,
      'comments': <Map<String, String>>[],
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadBlogEntries();
  }
  //Cargar la lista de entradas del blog desde sharepreferences
  Future<void> _loadBlogEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedBlogEntries = prefs.getString('blogEntries');
    if (savedBlogEntries != null) {
      try {
        setState(() {
          //Decodificar y asignar las entradas del blog guardadas
          blogEntries = (json.decode(savedBlogEntries) as List)
              .map((item) => {
                    'title': item['title'],
                    'content': item['content'],
                    'likes': item['likes'],
                    'comments': (item['comments'] as List)
                        .map((comment) => Map<String, String>.from(comment))
                        .toList(),
                  })
              .toList();
        });
      } catch (e) {
        // Limpia los datos corruptos
        await prefs.remove('blogEntries');
      }
    }
  }
  //Guardar las entradas en sharepreferences
  Future<void> _saveBlogEntries() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('blogEntries', json.encode(blogEntries));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Blog'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      backgroundColor: Colors.yellow,
      body: ListView.builder(
        itemCount: blogEntries.length,
        itemBuilder: (context, index) {
          final entry = blogEntries[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry['title'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    entry['content'],
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.thumb_up),
                        onPressed: () {
                          setState(() {
                            entry['likes']++;
                          });
                          _saveBlogEntries();
                        },
                      ),
                      Text('${entry['likes']} likes'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CommentSection(comments: entry['comments']),
                  AddCommentField(onSubmit: (String author, String comment) {
                    setState(() {
                      entry['comments'].add({'author': author, 'comment': comment});
                    });
                    _saveBlogEntries();
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  //Función para cerrar sesión
  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('isLoggedIn');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => InicioSesionPage()),
    );
  }
}
//Mostrar la sección de comentarios
class CommentSection extends StatelessWidget {
  final List<Map<String, String>> comments;

  const CommentSection({Key? key, required this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Comentarios:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        for (var comment in comments)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Text('- ${comment['author']}: ${comment['comment']}'),
          ),
      ],
    );
  }
}
//Añadir nuevo comentario
class AddCommentField extends StatefulWidget {
  final Function(String, String) onSubmit;

  const AddCommentField({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _AddCommentFieldState createState() => _AddCommentFieldState();
}

class _AddCommentFieldState extends State<AddCommentField> {
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _authorController,
          decoration: const InputDecoration(
            labelText: 'Tu nombre',
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: _commentController,
          decoration: const InputDecoration(
            labelText: 'Agregar un comentario',
          ),
        ),
        const SizedBox(height: 5),
        ElevatedButton(
          onPressed: () {
            if (_authorController.text.isNotEmpty && _commentController.text.isNotEmpty) {
              widget.onSubmit(_authorController.text, _commentController.text);
              _authorController.clear();
              _commentController.clear();
            }
          },
          child: const Text('Comentar'),
        ),
      ],
    );
  }
}















