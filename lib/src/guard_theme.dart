import 'package:json_type_guard/src/guard_style.dart';

class GuardTheme {
  /// Enable or disable ANSI color codes (default: false for compatibility)
  static bool useColors = false;

  static String errorPrefix = "JsonGuardError:";
  static String fieldLabel = "Field";
  static String expectedLabel = "Expected";
  static String receivedLabel = "Received";

  /// Set custom theme labels
  static void setTheme({
    String? errorPrefix,
    String? fieldLabel,
    String? expectedLabel,
    String? receivedLabel,
    bool? useColors,
  }) {
    if (errorPrefix != null) GuardTheme.errorPrefix = errorPrefix;
    if (fieldLabel != null) GuardTheme.fieldLabel = fieldLabel;
    if (expectedLabel != null) GuardTheme.expectedLabel = expectedLabel;
    if (receivedLabel != null) GuardTheme.receivedLabel = receivedLabel;
    if (useColors != null) GuardTheme.useColors = useColors;
  }

  /// Enable ANSI colors for terminal output
  static void enableColors() {
    useColors = true;
    errorPrefix = GuardStyle.color("JsonGuardError:", GuardStyle.red);
    fieldLabel = GuardStyle.boldText("Field");
    expectedLabel = GuardStyle.boldText("Expected");
    receivedLabel = GuardStyle.boldText("Received");
  }

  /// Disable ANSI colors (default)
  static void disableColors() {
    useColors = false;
    errorPrefix = "JsonGuardError:";
    fieldLabel = "Field";
    expectedLabel = "Expected";
    receivedLabel = "Received";
  }
}
