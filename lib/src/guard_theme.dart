import 'package:json_guard/src/guard_style.dart';

class GuardTheme {
  static String errorPrefix = GuardStyle.color(
    "JsonGuardError:",
    GuardStyle.red,
  );

  static String fieldLabel = GuardStyle.boldText("Field");
  static String expectedLabel = GuardStyle.boldText("Expected");
  static String receivedLabel = GuardStyle.boldText("Received");

  static void setTheme({
    String? errorPrefix,
    String? fieldLabel,
    String? expectedLabel,
    String? receivedLabel,
  }) {
    if (errorPrefix != null) GuardTheme.errorPrefix = errorPrefix;
    if (fieldLabel != null) GuardTheme.fieldLabel = fieldLabel;
    if (expectedLabel != null) GuardTheme.expectedLabel = expectedLabel;
    if (receivedLabel != null) GuardTheme.receivedLabel = receivedLabel;
  }
}
