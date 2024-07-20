class MathUtils {
  static double calculateDifferenceBtwTwoValues(double value1, double value2) {
    return value1 - value2;
  }

  static String calculateDifferenceBtwTwoValuesPercentage(double value1, double value2) {
    final value = (value1 - value2) / value1.abs() * 100;
    final result = value.isNaN ? 0 : value.roundToDouble();

    return result > 0 ? '+${result.toStringAsFixed(1).replaceAll('.', ',')}' : '-${result.toStringAsFixed(1).replaceAll('.', ',')}';
  }
}
