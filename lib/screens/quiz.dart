import 'package:flutter/material.dart';

class Quiz extends StatelessWidget {
  final int questionIndex;
  final List<Map<String, dynamic>> questions;
  final Function(int) answerQuestion;
  final VoidCallback? onAnswerSelected;

  const Quiz({
    super.key,
    required this.questionIndex,
    required this.questions,
    required this.answerQuestion,
    this.onAnswerSelected,
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
            questions[questionIndex]['questionText'],
            style: const TextStyle(fontSize: 18),
          ),
        ),
        const SizedBox(height: 25),
        ...((questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextButton(
              onPressed: () {
                answerQuestion(answer['score'] as int);
                if (onAnswerSelected != null) onAnswerSelected!();
              },
              style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all(const Size(double.infinity, 50)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
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
          );
        }))
      ],
    );
  }
}
