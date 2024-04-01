import 'package:flutter/material.dart';

class Quiz extends StatelessWidget {
  final int questionIndex;
  final List<Map<String, dynamic>> questions;
  final Function(int) answerQuestion;
  final VoidCallback? onAnswerSelected;
  final int? selectedAnswerIndex;
  final int correctAnswerIndex;

  const Quiz({
    super.key,
    required this.questionIndex,
    required this.questions,
    required this.answerQuestion,
    this.onAnswerSelected,
    this.selectedAnswerIndex,
    required this.correctAnswerIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            questions[questionIndex]['questionText'] as String,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        const SizedBox(height: 25),
        ...((questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .asMap()
            .map((index, answer) {
          bool isCorrectAnswer =
              index == correctAnswerIndex && answer['score'] == 100;
          bool isWrongAnswer =
              index == selectedAnswerIndex && answer['score'] == 0;
          bool isAnswerSelected = selectedAnswerIndex != null;

          Color? backgroundColor;
          if (isCorrectAnswer && isAnswerSelected) {
            backgroundColor = Colors.green.withOpacity(0.5);
          } else if (isWrongAnswer) {
            backgroundColor = Colors.red.withOpacity(0.5);
          } else {
            backgroundColor = Colors.white;
          }

          return MapEntry(
            index,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextButton(
                onPressed: () {
                  if (!isAnswerSelected) {
                    answerQuestion(index);
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(backgroundColor),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                child: Text(answer['text'] as String),
              ),
            ),
          );
        })).values,
      ],
    );
  }
}
