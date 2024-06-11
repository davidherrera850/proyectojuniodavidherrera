import 'package:flutter/material.dart';

class ArbitrajePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Normativa de Árbitros'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.yellow,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSection(
              'Árbitro de Primera División',
              [
                'Debe poseer al menos 5 años de experiencia como árbitro.',
                'Capacidad para dirigir partidos de alta competición con VAR.',
                'Cumplir con los estándares físicos y técnicos establecidos por la federación.',
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Árbitro de Segunda División',
              [
                'Al menos 3 años de experiencia en ligas menores.',
                'Habilidad para aplicar las reglas del juego de manera consistente.',
                'Capacidad para trabajar bajo presión y tomar decisiones rápidas.',
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Árbitro de Categorías Juveniles',
              [
                'Conocimiento profundo de las reglas del fútbol para menores.',
                'Capacidad para educar a los jugadores jóvenes sobre las reglas del juego.',
                'Actitud ejemplar y capacidad para manejar situaciones conflictivas de manera diplomática.',
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items
              .map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '• $item',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
