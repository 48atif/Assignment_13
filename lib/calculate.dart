class CalculateBMI {
  // Convert pound → kg
  static double lbToKg(double lb) => lb * 0.45359237;

  // Convert cm → m
  static double cmToM(double cm) => cm / 100;

  // Convert feet + inch → meter
  static double heightFtToMeter(double ft, double inch) {
    return (ft * 12 + inch) * 0.0254;
  }

  // Master BMI calculation
  static double calculateBMI(
      double weight, String weightUnit, double heightValue, String heightUnit) {
    
    double weightKg = weightUnit == "kg" ? weight : lbToKg(weight);
    double heightM;

    if (heightUnit == "m") {
      heightM = heightValue;
    } else if (heightUnit == "cm") {
      heightM = cmToM(heightValue);
    } else {
      heightM = heightValue; // already converted from ft
    }

    double bmi = weightKg / (heightM * heightM);
    return double.parse(bmi.toStringAsFixed(1)); // 1 decimal
  }

  // Return category + color
  static Map<String, dynamic> getCategory(double bmi) {
    if (bmi < 18.5) {
      return {"text": "Underweight", "color": "blue"};
    } else if (bmi < 25) {
      return {"text": "Normal", "color": "green"};
    } else if (bmi < 30) {
      return {"text": "Overweight", "color": "orange"};
    } else {
      return {"text": "Obese", "color": "red"};
    }
  }
}
