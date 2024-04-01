import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_app/data/questions_list.dart';
import 'package:quiz_app/screens/quiz.dart';
import 'package:quiz_app/screens/result.dart';
import 'dart:async';

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  late Timer _timer;
  int _timerSeconds = 10;
  int _questionIndex = 0;
  int _totalScore = 0;
  bool _answerSelected = false;
  int? _selectedAnswerIndex;

  final List<Map<String, dynamic>> _questions = QuizData.questions;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _answerQuestion(int index) {
    setState(() {
      _answerSelected = true;
      _selectedAnswerIndex = index;
    });
  }

  void _startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (Timer timer) {
      setState(() {
        if (_timerSeconds > 0) {
          _timerSeconds--;
        } else {
          timer.cancel();
          goToNextQuestion();
        }
      });
    });
  }

  void goToNextQuestion() {
    if (_answerSelected) {
      setState(() {
        _totalScore += _questions[_questionIndex]['answers']
            [_selectedAnswerIndex!]['score'] as int;
        _questionIndex++;
        _answerSelected = false;
        _selectedAnswerIndex = null;
        _timerSeconds = 10;
      });
    } else {
      setState(() {
        _questionIndex++;
        _answerSelected = false;
        _selectedAnswerIndex = null;
        _timerSeconds = 10;
      });
    }

    _timer.cancel();
    if (_questionIndex < _questions.length) {
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text(
                  _questionIndex < _questions.length
                      ? 'Question ${_questionIndex + 1}'
                      : '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            Text(
              _questionIndex < _questions.length
                  ? '00:${_timerSeconds.toString().padLeft(2, '0')}'
                  : '',
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
          ],
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
                    selectedAnswerIndex: _selectedAnswerIndex,
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
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
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
