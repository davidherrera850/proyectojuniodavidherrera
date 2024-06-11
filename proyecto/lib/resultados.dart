import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResultadosPage extends StatefulWidget {
  const ResultadosPage({Key? key}) : super(key: key);

  @override
  _ResultadosPageState createState() => _ResultadosPageState();
}

class _ResultadosPageState extends State<ResultadosPage> {
  // Lista para almacenar los partidos
  List _matches = [];
  List _filteredMatches = [];
  // Icono de carga
  bool _isLoading = true;
  // Controlador de texto para la barra de búsqueda
  final TextEditingController _searchController = TextEditingController();

  // Inserta clave de API de Football-Data.org aquí
  final String apiKey = '8ed7c6f91cdf4630935eaea26718f7ba';

  @override
  void initState() {
    super.initState();
    // Llamar a la función para obtener los partidos
    _fetchMatches();
    // Agregar un listener al controlador de búsqueda
    _searchController.addListener(_filterMatches);
  }

  @override
  void dispose() {
    // Limpiar el controlador de búsqueda
    _searchController.dispose();
    super.dispose();
  }

  // Función para obtener los partidos de la API
  Future<void> _fetchMatches() async {
    final response = await http.get(
      Uri.parse('https://api.football-data.org/v2/competitions/2014/matches'), // La ID '2014' es para La Liga Española.
      headers: {
        'X-Auth-Token': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        // Ponemos los partidos en la lista
        _matches = data['matches'];
        _filteredMatches = _matches;
        _isLoading = false;
      });
    } else {
      // Lanzamos una excepción si falla la carga
      throw Exception('Fallo al cargar los partidos');
    }
  }

  // Función para filtrar los partidos según la búsqueda
  void _filterMatches() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredMatches = _matches.where((match) {
        final homeTeam = match['homeTeam']['name'].toLowerCase();
        final awayTeam = match['awayTeam']['name'].toLowerCase();
        return homeTeam.contains(query) || awayTeam.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Liga Española Resultados"),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar equipo...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search, color: Colors.red),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.yellow,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _filteredMatches.length,
              itemBuilder: (context, index) {
                final match = _filteredMatches[index];
                final homeTeam = match['homeTeam']['name'];
                final awayTeam = match['awayTeam']['name'];
                final homeScore = match['score']['fullTime']['homeTeam'];
                final awayScore = match['score']['fullTime']['awayTeam'];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$homeTeam vs $awayTeam',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Resultado: $homeScore - $awayScore',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
