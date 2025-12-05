class JsonFieldError extends Error {
  /// this is the key causing the error
  final String key;

  /// This represents the type expected.
  final Type expected;

  /// This represents the type recieved.
  final dynamic received;

  JsonFieldError({
    required this.key,
    required this.expected,
    required this.received,
  });

  @override
  String toString() {
    return 'JsonFieldError: Expected $expected for `$key`, but got '
        '${received.runtimeType} ($received)';
  }
}
