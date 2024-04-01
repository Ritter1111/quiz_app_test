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
  int? selectedAnswerIndex;
  int _totalScore = 0;

  final List<Map<String, dynamic>> _questions = QuizData.questions;

  void _answerQuestion(int score) {
    setState(() {
      _totalScore += score;
      // _questionIndex++;
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
                  ),
                ],
              )
            : Result(_totalScore),
      ),
    );
  }
}
