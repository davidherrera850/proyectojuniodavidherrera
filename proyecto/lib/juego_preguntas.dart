//Importamos los paquetes necesarios
import 'package:flutter/material.dart';
import 'dart:math';

class JuegoPreguntasPage extends StatefulWidget {
  const JuegoPreguntasPage({Key? key}) : super(key: key);

  @override
  _JuegoPreguntasPageState createState() => _JuegoPreguntasPageState();
}

class _JuegoPreguntasPageState extends State<JuegoPreguntasPage> {
  //Lista de preguntas
  final List<Map<String, Object>> _allQuestions = [
    {
      'question': '¿Quién ha ganado más Copas del Mundo?',
      'answers': [
        {'text': 'Brasil', 'correct': true},
        {'text': 'Alemania', 'correct': false},
        {'text': 'Italia', 'correct': false},
        {'text': 'Argentina', 'correct': false},
      ],
    },
    {
      'question': '¿Quién es conocido como "El Pibe de Oro"?',
      'answers': [
        {'text': 'Pelé', 'correct': false},
        {'text': 'Diego Maradona', 'correct': true},
        {'text': 'Lionel Messi', 'correct': false},
        {'text': 'Cristiano Ronaldo', 'correct': false},
      ],
    },
    {
      'question': '¿Quién es conocido como "La pulga"?',
      'answers': [
        {'text': 'Lionel Messi', 'correct': true},
        {'text': 'Cristiano Ronaldo', 'correct': false},
        {'text': 'Neymar Junior', 'correct': false},
        {'text': 'Vinicius Junior', 'correct': false},
      ],
    },
    {
      'question': '¿Cada cuanto tiempo se celebran los mundiales de selecciones?',
      'answers': [
        {'text': 'Cada 2 años', 'correct': false},
        {'text': 'Cada 4 años', 'correct': true},
        {'text': 'Cada año', 'correct': false},
        {'text': 'Cada 5 años', 'correct': false},
      ],
    },
    {
      'question': '¿Cuántos balones de oro tiene Lionel Messi y Cristiano Ronaldo?',
      'answers': [
        {'text': 'Cristiano Ronaldo 2, Lionel Messi 3', 'correct': false},
        {'text': 'Cristiano Ronaldo 4, Lionel Messi 8', 'correct': false},
        {'text': 'Cristiano Ronaldo 5, Lionel Messi 6', 'correct': false},
        {'text': 'Cristiano Ronaldo 5, Lionel Messi 8', 'correct': true},
      ],
    },
    {
      'question': '¿Quienes son los únicos 2 equipos que tienen en sus vitrinas un sextete?',
      'answers': [
        {'text': 'Real Madrid y Manchester City', 'correct': false},
        {'text': 'Barcelona y Real Madrid', 'correct': false},
        {'text': 'Barcelona y Bayern', 'correct': true},
        {'text': 'Real Madrid y PSG', 'correct': false},
      ],
    },
    {
      'question': '¿Cuántos equipos tiene la liga española?',
      'answers': [
        {'text': '21', 'correct': false},
        {'text': '18', 'correct': false},
        {'text': '20', 'correct': true},
        {'text': '10', 'correct': false},
      ],
    },
    {
      'question': '¿Qué equipos son catalanes?',
      'answers': [
        {'text': 'Real Madrid y Sevilla', 'correct': false},
        {'text': 'Betis y Cádiz', 'correct': false},
        {'text': 'Las Palmas y Mallorca', 'correct': false},
        {'text': 'Barcelona y Girona', 'correct': true},
      ],
    },
    {
      'question': '¿A qué partido se le llama el clásico?',
      'answers': [
        {'text': 'Madrid-Atlético', 'correct': false},
        {'text': 'Barcelona-Madrid', 'correct': true},
        {'text': 'No hay ninguno', 'correct': false},
        {'text': 'Sevilla-Betis', 'correct': false},
      ],
    },
    // Puedes agregar más preguntas aquí
  ];

  late List<Map<String, Object>> _questions;
  int _currentQuestionIndex = 0;
  bool _showAnswer = false;
  bool _isCorrect = false;
  int _correctAnswers = 0;
  int _incorrectAnswers = 0;

  @override
  void initState() {
    super.initState();
    _loadRandomQuestions();
  }

  //Función para cargar preguntas aleatorias
  void _loadRandomQuestions() {
    final random = Random();
    _questions = List<Map<String, Object>>.from(_allQuestions)..shuffle(random);
    _questions = _questions.take(3).toList(); // Tomamos solo 3 preguntas aleatorias
    _currentQuestionIndex = 0;
    _showAnswer = false;
    _isCorrect = false;
    _correctAnswers = 0;
    _incorrectAnswers = 0;
  }

  //Función para manejar la respuesta a una pregunta
  void _answerQuestion(bool isCorrect) {
    if (!_showAnswer) {
      setState(() {
        _showAnswer = true;
        _isCorrect = isCorrect;
        if (isCorrect) {
          _correctAnswers++;
        } else {
          _incorrectAnswers++;
        }
      });
    }
  }

  //Función para pasar a la siguiente pregunta o mostrar el diálogo de fin del juego
  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _showAnswer = false;
        _isCorrect = false;
      } else {
        _showEndDialog();
      }
    });
  }

  //Función para mostrar el diálogo de fin del juego
  void _showEndDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Fin del juego'),
          content: Text(
              'Has terminado el juego, gracias por jugar.\n\nRespuestas correctas: $_correctAnswers\nRespuestas incorrectas: $_incorrectAnswers'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _loadRandomQuestions();
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Juego de Preguntas',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.yellow,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion['question'] as String,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...(currentQuestion['answers'] as List<Map<String, Object>>).map((answer) {
              return GestureDetector(
                onTap: _showAnswer ? null : () => _answerQuestion(answer['correct'] as bool),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    answer['text'] as String,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              );
            }).toList(),
            if (_showAnswer)
              Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    _isCorrect ? '¡Correcto!' : 'Incorrecto',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: _isCorrect ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    child: const Text('Siguiente Pregunta'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

