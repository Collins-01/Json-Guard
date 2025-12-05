import 'package:json_type_guard/src/errors/errors.dart';

class Guard {
  static bool _debug = false;

  static void setDebugLogging(bool value) {
    _debug = value;
  }

  static bool get debug => _debug;

  /// Any field  (generic version.)
  static T value<T>(Map json, String key, {T? defaultValue}) {
    final raw = json[key];

    if (raw == null) {
      if (defaultValue != null) return defaultValue;

      throw JsonFieldError(key: key, expected: T, received: null);
    }

    if (raw is T) return raw;

    throw JsonFieldError(key: key, expected: T, received: raw);
  }

  /// Nullable version  (returns null instead of error.)
  static T? valueOrNull<T>(Map json, String key) {
    final raw = json[key];
    if (raw == null) return null;

    if (raw is T) return raw;

    throw JsonFieldError(key: key, expected: T, received: raw);
  }

  /// Guard object parsing
  static T object<T>(Map json, String key, T Function(Map value) builder) {
    final raw = json[key];

    if (raw == null || raw is! Map) {
      throw JsonFieldError(key: key, expected: Map, received: raw);
    }

    return builder(raw);
  }

  /// Guard list parsing
  static List<T> list<T>(Map json, String key, T Function(dynamic v) convert) {
    final raw = json[key];

    if (raw == null || raw is! List) {
      throw JsonFieldError(key: key, expected: List, received: raw);
    }

    return raw.map(convert).toList();
  }
}
