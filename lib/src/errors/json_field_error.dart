import 'package:json_type_guard/src/guard_theme.dart';

class JsonFieldError extends Error {
  /// this is the key causing the error
  final String key;

  /// This represents the type expected.
  final Type expected;

  /// This represents the type recieved.
  final dynamic received;

  /// The full path to the field in the JSON structure (e.g., "user.profile.address.city")
  /// If null, defaults to using just the key
  final String? path;

  JsonFieldError({
    required this.key,
    required this.expected,
    required this.received,
    this.path,
  });

  @override
  String toString() {
    final fieldPath = path ?? key;
    return '${GuardTheme.errorPrefix}\n'
        '  ${GuardTheme.fieldLabel}: "$fieldPath"\n'
        '  ${GuardTheme.expectedLabel}: $expected\n'
        '  ${GuardTheme.receivedLabel}: ${received.runtimeType} ($received)';
  }
}
