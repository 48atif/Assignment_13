import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BMI Calculator",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // optional, looks modern
      ),
      home: HomePage(),
    );
  }
}
