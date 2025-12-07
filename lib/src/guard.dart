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

  /// Guard DateTime parsing
  /// Supports ISO8601 strings, Unix timestamps (seconds), and Unix timestamps (milliseconds)
  static DateTime dateTime(Map json, String key, {String? path}) {
    final raw = json[key];
    final fieldPath = path != null ? '$path.$key' : key;

    if (raw == null) {
      throw JsonFieldError(
        key: key,
        expected: DateTime,
        received: null,
        path: fieldPath,
      );
    }

    // Try parsing as ISO8601 string
    if (raw is String) {
      try {
        return DateTime.parse(raw);
      } catch (e) {
        throw JsonFieldError(
          key: key,
          expected: DateTime,
          received: raw,
          path: fieldPath,
        );
      }
    }

    // Try parsing as Unix timestamp (int)
    if (raw is int) {
      try {
        // Determine if seconds or milliseconds based on magnitude
        // Timestamps < 10,000,000,000 are in seconds (covers dates up to year 2286)
        // Timestamps >= 10,000,000,000 are in milliseconds
        if (raw < 10000000000) {
          return DateTime.fromMillisecondsSinceEpoch(raw * 1000);
        } else {
          return DateTime.fromMillisecondsSinceEpoch(raw);
        }
      } catch (e) {
        throw JsonFieldError(
          key: key,
          expected: DateTime,
          received: raw,
          path: fieldPath,
        );
      }
    }

    // Invalid type
    throw JsonFieldError(
      key: key,
      expected: DateTime,
      received: raw,
      path: fieldPath,
    );
  }

  /// Nullable DateTime parsing (returns null instead of error when missing)
  static DateTime? dateTimeOrNull(Map json, String key, {String? path}) {
    final raw = json[key];
    final fieldPath = path != null ? '$path.$key' : key;

    if (raw == null) return null;

    // Try parsing as ISO8601 string
    if (raw is String) {
      try {
        return DateTime.parse(raw);
      } catch (e) {
        throw JsonFieldError(
          key: key,
          expected: DateTime,
          received: raw,
          path: fieldPath,
        );
      }
    }

    // Try parsing as Unix timestamp (int)
    if (raw is int) {
      try {
        if (raw < 10000000000) {
          return DateTime.fromMillisecondsSinceEpoch(raw * 1000);
        } else {
          return DateTime.fromMillisecondsSinceEpoch(raw);
        }
      } catch (e) {
        throw JsonFieldError(
          key: key,
          expected: DateTime,
          received: raw,
          path: fieldPath,
        );
      }
    }

    // Invalid type
    throw JsonFieldError(
      key: key,
      expected: DateTime,
      received: raw,
      path: fieldPath,
    );
  }
}
