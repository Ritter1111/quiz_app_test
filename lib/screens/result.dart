import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int totalScore;

  const Result(this.totalScore, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Your Total Score: $totalScore',
        style: const TextStyle(fontSize: 30),
      ),
    );
  }
}
