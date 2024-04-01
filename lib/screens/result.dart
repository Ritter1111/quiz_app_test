import 'package:flutter/material.dart';
import 'package:quiz_app/screens/main.dart';

class Result extends StatelessWidget {
  final int totalScore;

  const Result(this.totalScore, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Your Total Score: $totalScore',
              style: const TextStyle(fontSize: 27),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const QuizApp()),
              );
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
            child: const Text('Go Back'),
          ),
        ],
      ),
    );
  }
}
