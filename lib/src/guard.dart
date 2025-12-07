import 'package:json_type_guard/src/errors/errors.dart';

class Guard {
  static bool _debug = false;

  static void setDebugLogging(bool value) {
    _debug = value;
  }

  static bool get debug => _debug;

  /// Any field  (generic version.)
  static T value<T>(Map json, String key, {T? defaultValue, String? path}) {
    final raw = json[key];
    final fieldPath = path != null ? '$path.$key' : key;

    if (raw == null) {
      if (defaultValue != null) return defaultValue;

      throw JsonFieldError(
        key: key,
        expected: T,
        received: null,
        path: fieldPath,
      );
    }

    if (raw is T) return raw;

    throw JsonFieldError(key: key, expected: T, received: raw, path: fieldPath);
  }

  /// Nullable version  (returns null instead of error.)
  static T? valueOrNull<T>(Map json, String key, {String? path}) {
    final raw = json[key];
    final fieldPath = path != null ? '$path.$key' : key;
    if (raw == null) return null;

    if (raw is T) return raw;

    throw JsonFieldError(key: key, expected: T, received: raw, path: fieldPath);
  }

  /// Guard object parsing
  static T object<T>(
    Map json,
    String key,
    T Function(Map value) builder, {
    String? path,
  }) {
    final raw = json[key];
    final fieldPath = path != null ? '$path.$key' : key;

    if (raw == null || raw is! Map) {
      throw JsonFieldError(
        key: key,
        expected: Map,
        received: raw,
        path: fieldPath,
      );
    }

    return builder(raw);
  }

  /// Guard list parsing
  static List<T> list<T>(
    Map json,
    String key,
    T Function(dynamic v) convert, {
    String? path,
  }) {
    final raw = json[key];
    final fieldPath = path != null ? '$path.$key' : key;

    if (raw == null || raw is! List) {
      throw JsonFieldError(
        key: key,
        expected: List,
        received: raw,
        path: fieldPath,
      );
    }

    return raw.map(convert).toList();
  }
}
