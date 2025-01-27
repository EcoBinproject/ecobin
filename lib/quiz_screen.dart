import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  String _selectedDifficulty = "Facile";
  bool _isAnswerSelected = false;
  int _timer = 15; // Timer per ogni domanda
  late final Timer _countdownTimer;

  final Map<String, List<Map<String, dynamic>>> _questionsByDifficulty = {
    "Facile": [
      {
        "question": "Quale materiale è riciclabile?",
        "options": ["Plastica", "Vetro", "Carta", "Tutte le precedenti"],
        "answer": "Tutte le precedenti",
        "icon": Icons.recycling
      },
      {
        "question": "Dove si butta una bottiglia di plastica?",
        "options": ["Indifferenziata", "Organico", "Plastica", "Vetro"],
        "answer": "Plastica",
        "icon": Icons.delete_outline
      },
      {
        "question": "Qual è il simbolo del riciclo?",
        "options": [
          "Cerchio verde",
          "Freccia blu",
          "Tre frecce verdi",
          "Quadrato rosso"
        ],
        "answer": "Tre frecce verdi",
        "icon": Icons.autorenew
      },
    ],
    "Medio": [
      {
        "question": "Qual è il tempo di degradazione di una lattina?",
        "options": ["10 anni", "100 anni", "500 anni", "Indefinito"],
        "answer": "100 anni",
        "icon": Icons.coffee
      },
      {
        "question": "Come si smaltisce un vecchio cellulare?",
        "options": ["Indifferenziata", "Isola ecologica", "Organico", "Carta"],
        "answer": "Isola ecologica",
        "icon": Icons.phone_android
      },
      {
        "question": "Quale di questi rifiuti è pericoloso?",
        "options": ["Carta", "Batterie", "Vetro", "Plastica"],
        "answer": "Batterie",
        "icon": Icons.battery_alert
      },
    ],
    "Difficile": [
      {
        "question": "Quale di questi non è biodegradabile?",
        "options": [
          "Bucce di banana",
          "Sacchetti di plastica",
          "Foglie",
          "Carta"
        ],
        "answer": "Sacchetti di plastica",
        "icon": Icons.not_interested
      },
      {
        "question": "Quanta plastica finisce negli oceani ogni anno?",
        "options": [
          "1 milione di tonnellate",
          "8 milioni di tonnellate",
          "50 milioni di tonnellate",
          "100 milioni di tonnellate"
        ],
        "answer": "8 milioni di tonnellate",
        "icon": Icons.water_drop
      },
      {
        "question": "Quale paese ricicla di più in Europa?",
        "options": ["Germania", "Italia", "Francia", "Sp agna"],
        "answer": "Germania",
        "icon": Icons.flag
      },
    ]
  };

  List<Map<String, dynamic>> get _currentQuestions =>
      _questionsByDifficulty[_selectedDifficulty]!;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timer > 0) {
        setState(() {
          _timer--;
        });
      } else {
        _checkAnswer(
            ""); // Se il tempo scade, considera la risposta come non corretta
      }
    });
  }

  void _checkAnswer(String selectedOption) {
    setState(() {
      _isAnswerSelected = true;
    });

    if (selectedOption == _currentQuestions[_currentQuestionIndex]["answer"]) {
      _score++;
    }

    Future.delayed(Duration(seconds: 1), () {
      if (_currentQuestionIndex < _currentQuestions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _isAnswerSelected = false;
          _timer = 15; // Reset del timer
        });
      } else {
        _showResult();
      }
    });
  }

  void _showResult() {
    _countdownTimer.cancel(); // Ferma il timer
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Quiz Completato!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset('assets/animations/trophy.json', height: 150),
            SizedBox(height: 10),
            Text("Hai ottenuto $_score punti!",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700])),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentQuestionIndex = 0;
                _score = 0;
                _timer = 15; // Reset del timer
              });
              _startTimer(); // Riavvia il timer
            },
            child: Text("Riprova", style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _countdownTimer.cancel(); // Ferma il timer quando il widget viene distrutto
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EcoQuiz",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green)),
        backgroundColor: Colors.white,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Selezione della difficoltà
              Text("Seleziona la difficoltà:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                value: _selectedDifficulty,
                items:
                    ["Facile", "Medio", "Difficile"].map((String difficulty) {
                  return DropdownMenuItem<String>(
                    value: difficulty,
                    child: Text(difficulty,
                        style:
                            TextStyle(fontSize: 16, color: Colors.green[700])),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDifficulty = value!;
                    _currentQuestionIndex = 0;
                    _score = 0;
                    _isAnswerSelected = false;
                    _timer = 15; // Reset del timer
                  });
                },
              ),
              SizedBox(height: 20),

              // Icona e Domanda
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _currentQuestions[_currentQuestionIndex]["icon"],
                    size: 50,
                    color: Colors.green[700],
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Text(
                        _currentQuestions[_currentQuestionIndex]["question"],
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Timer
              Text("Tempo rimasto: $_timer secondi",
                  style: TextStyle(fontSize: 18, color: Colors.red)),
              SizedBox(height: 20),

              // Risposte con design accattivante e responsive
              ..._currentQuestions[_currentQuestionIndex]["options"]
                  .map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: _isAnswerSelected
                          ? (option ==
                                  _currentQuestions[_currentQuestionIndex]
                                      ["answer"]
                              ? Colors.green[700]
                              : Colors.red[700])
                          : Colors.green[600],
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(vertical: 18),
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed:
                          _isAnswerSelected ? null : () => _checkAnswer(option),
                      child: Text(option,
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                );
              }).toList(),

              // Barra di progresso
              SizedBox(height: 20),
              LinearProgressIndicator(
                value: (_currentQuestionIndex + 1) / _currentQuestions.length,
                backgroundColor: Colors.grey[300],
                color: Colors.green[700],
              ),

              // Sezione per statistiche di gioco
              SizedBox(height: 20),
              Text("Statistiche di Gioco",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("Punteggio: $_score", style: TextStyle(fontSize: 16)),
              Text(
                  "Domande corrette: ${(_score / (_currentQuestionIndex + 1) * 100).toStringAsFixed(2)}%",
                  style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
