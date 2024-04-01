import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions_list.dart';
import 'package:quiz_app/screens/quiz.dart';
import 'package:quiz_app/screens/result.dart';

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int _questionIndex = 0;
  int _totalScore = 0;
  bool _answerSelected = false;

  final List<Map<String, dynamic>> _questions = QuizData.questions;

  void _answerQuestion(int score) {
    setState(() {
      _totalScore += score;
      _answerSelected = true;
    });
  }

  void goToNextQuestion() {
    setState(() {
      _questionIndex++;
      _answerSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _questionIndex < _questions.length
              ? 'Question ${_questionIndex + 1}'
              : '',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(
            color: Colors.grey,
            height: 0.5,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: _questionIndex < _questions.length
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Quiz(
                    questionIndex: _questionIndex,
                    questions: _questions,
                    answerQuestion: _answerQuestion,
                    onAnswerSelected: () {
                      setState(() {
                        _answerSelected = true;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: _answerSelected ? goToNextQuestion : null,
                    style: ButtonStyle(
                        backgroundColor: _answerSelected
                            ? MaterialStateProperty.all<Color>(Colors.green)
                            : MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 211, 224, 212)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                    child: const Text('Next Question'),
                  )
                ],
              )
            : Result(_totalScore),
      ),
    );
  }
}
