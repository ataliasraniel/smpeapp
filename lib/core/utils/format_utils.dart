class FormatUtils {
  static String formatCpf(String value) {
    if (value.length == 11) {
      return value.replaceAllMapped(RegExp(r"(\d{3})(\d{3})(\d{3})(\d{2})"), (match) => "${match[1]}.${match[2]}.${match[3]}-${match[4]}");
    }
    return value;
  }

  static String formatPhone(String value) {
    if (value.length == 11) {
      return value.replaceAllMapped(RegExp(r"(\d{2})(\d{5})(\d{4})"), (match) => "(${match[1]}) ${match[2]}-${match[3]}");
    }
    return value;
  }

  static bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegExp.hasMatch(email);
  }

  static bool isValidCpf(String cpf) {
    // Remove non-numeric characters from CPF
    cpf = cpf.replaceAll(RegExp(r'[^\d]'), '');

    // Check if CPF has 11 digits
    if (cpf.length != 11) {
      return false;
    }

    // Calculate verification digits
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(cpf[i]) * (10 - i);
    }
    int firstVerificationDigit = 11 - (sum % 11);

    if (firstVerificationDigit == 10 || firstVerificationDigit == 11) {
      firstVerificationDigit = 0;
    }

    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += int.parse(cpf[i]) * (11 - i);
    }
    int secondVerificationDigit = 11 - (sum % 11);

    if (secondVerificationDigit == 10 || secondVerificationDigit == 11) {
      secondVerificationDigit = 0;
    }

    // Check if verification digits are correct
    if (int.parse(cpf[9]) == firstVerificationDigit && int.parse(cpf[10]) == secondVerificationDigit) {
      return true;
    } else {
      return false;
    }
  }

  static String convertMinutesToHours(int minutes) {
    final int hours = minutes ~/ 60;
    final int remainingMinutes = minutes % 60;
    return '$hours:$remainingMinutes';
  }

  static String convertHoursToMinutes(String hours) {
    final int hoursInMinutes = int.parse(hours) * 60;
    return hoursInMinutes.toString();
  }

  static String purifyCPF(String? text) {
    if (text == null) {
      return '';
    }
    return text.replaceAll(RegExp(r'[^\d]'), '');
  }

  static purifyCNPJ(String text) {
    return text.replaceAll(RegExp(r'[^\d]'), '');
  }
}
