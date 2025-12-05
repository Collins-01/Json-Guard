import 'guard.dart';

extension JsonGuardExt on Map {
  T guard<T>(String key, {T? defaultValue}) =>
      Guard.value<T>(this, key, defaultValue: defaultValue);

  T? guardOrNull<T>(String key) => Guard.valueOrNull<T>(this, key);

  List<T> guardList<T>(String key, T Function(dynamic) convert) =>
      Guard.list(this, key, convert);

  T guardObject<T>(String key, T Function(Map m) builder) =>
      Guard.object(this, key, builder);
}
