import 'package:flutter/material.dart';
import 'calculate.dart';
import 'result_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Controllers
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController(); // For m & cm
  TextEditingController feetController = TextEditingController();
  TextEditingController inchController = TextEditingController();

  // Toggles
  String weightUnit = "kg"; // kg or lb
  String heightUnit = "cm"; // m, cm, ft

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BMI Calculator")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Weight
            Text("Weight"),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: weightController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(labelText: "Enter weight"),
                  ),
                ),
                SizedBox(width: 12),
                ToggleButtons(
                  isSelected: [weightUnit == "kg", weightUnit == "lb"],
                  onPressed: (index) {
                    setState(() {
                      weightUnit = index == 0 ? "kg" : "lb";
                    });
                  },
                  children: [
                    Padding(padding: EdgeInsets.all(8), child: Text("KG")),
                    Padding(padding: EdgeInsets.all(8), child: Text("LB")),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20),

            // Height
            Text("Height"),
            ToggleButtons(
              isSelected: [
                heightUnit == "m",
                heightUnit == "cm",
                heightUnit == "ft",
              ],
              onPressed: (index) {
                setState(() {
                  heightUnit = ["m", "cm", "ft"][index];
                });
              },
              children: [
                Padding(padding: EdgeInsets.all(8), child: Text("M")),
                Padding(padding: EdgeInsets.all(8), child: Text("CM")),
                Padding(padding: EdgeInsets.all(8), child: Text("FT+IN")),
              ],
            ),

            SizedBox(height: 12),

            // Height Inputs
            if (heightUnit == "m" || heightUnit == "cm")
              TextField(
                controller: heightController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: heightUnit == "m" ? "Enter meters" : "Enter centimeters",
                ),
              ),

            if (heightUnit == "ft")
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: feetController,
                      keyboardType: TextInputType.numberWithOptions(decimal: false),
                      decoration: InputDecoration(labelText: "Feet"),
                      onChanged: (v) {},
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: inchController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(labelText: "Inches"),
                      onChanged: (v) {
                        // Auto carry if inch >= 12
                        double? inches = double.tryParse(v);
                        if (inches != null && inches >= 12) {
                          int extraFeet = inches ~/ 12;
                          double remainingInch = inches % 12;

                          feetController.text =
                              ((int.tryParse(feetController.text) ?? 0) + extraFeet).toString();
                          inchController.text = remainingInch.toStringAsFixed(1);
                        }
                      },
                    ),
                  ),
                ],
              ),

            SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                child: Text("CALCULATE BMI"),
                onPressed: () {
                  if (!_validate()) return;

                  double weight = double.parse(weightController.text);
                  double heightValue;

                  double? feet = double.tryParse(feetController.text);
                  double? inch = double.tryParse(inchController.text);

                  if (heightUnit == "ft") {
                    heightValue = CalculateBMI.heightFtToMeter(
                      feet ?? 0,
                      inch ?? 0,
                    );
                  } else {
                    heightValue = double.parse(heightController.text);
                  }

                  double bmi = CalculateBMI.calculateBMI(
                    weight,
                    weightUnit,
                    heightValue,
                    heightUnit,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ResultPage(bmi: bmi),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validate() {
    if (weightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter weight")),
      );
      return false;
    }

    if (heightUnit != "ft" && heightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter height")),
      );
      return false;
    }

    if (heightUnit == "ft" &&
        (feetController.text.isEmpty || inchController.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter feet & inches")),
      );
      return false;
    }

    return true;
  }
}
