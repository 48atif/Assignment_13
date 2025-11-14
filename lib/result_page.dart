import 'package:flutter/material.dart';
import 'calculate.dart';

class ResultPage extends StatelessWidget {
  final double bmi;

  ResultPage({required this.bmi});

  @override
  Widget build(BuildContext context) {
    final info = CalculateBMI.getCategory(bmi);
    final color = _mapColor(info["color"]);

    return Scaffold(
      appBar: AppBar(title: Text("Your Result")),
      body: Center(
        child: Card(
          color: color.withOpacity(0.2),
          elevation: 4,
          margin: EdgeInsets.all(20),
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "BMI: $bmi",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Chip(
                  label: Text(
                    info["text"],
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: color,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _mapColor(String c) {
    switch (c) {
      case "blue":
        return Colors.blue;
      case "green":
        return Colors.green;
      case "orange":
        return Colors.orange;
      default:
        return Colors.red;
    }
  }
}
