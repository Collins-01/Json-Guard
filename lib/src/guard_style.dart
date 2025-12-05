class GuardStyle {
  static const reset = '\x1B[0m';

  static const red = '\x1B[31m';
  static const yellow = '\x1B[33m';
  static const blue = '\x1B[34m';

  static const bold = '\x1B[1m';
  static const underline = '\x1B[4m';

 
  static String color(String text, String colorCode) => '$colorCode$text$reset';

  static String boldText(String text) => '$bold$text$reset';
}
