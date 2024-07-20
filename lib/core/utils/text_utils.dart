class TextUtils {
  static String formatNameToTwoNames(String name) {
    final names = name.split(' ');
    if (names.length > 1) {
      return '${names[0]} ${names[1]}';
    }
    return name;
  }
}
