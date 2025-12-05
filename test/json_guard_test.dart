import 'package:json_type_guard/json_type_guard.dart';
import 'package:test/test.dart';

void main() {
  group('Guard.value', () {
    test('extracts correct type successfully', () {
      final json = {'name': 'Alice', 'age': 30};

      expect(Guard.value<String>(json, 'name'), equals('Alice'));
      expect(Guard.value<int>(json, 'age'), equals(30));
    });

    test('uses default value when field is missing', () {
      final json = {'name': 'Bob'};

      expect(Guard.value<String>(json, 'role', defaultValue: 'user'),
          equals('user'));
    });

    test('throws JsonFieldError when type mismatch', () {
      final json = {'age': '30'};

      expect(
        () => Guard.value<int>(json, 'age'),
        throwsA(isA<JsonFieldError>()),
      );
    });

    test('throws JsonFieldError when required field is missing', () {
      final json = {'name': 'Charlie'};

      expect(
        () => Guard.value<int>(json, 'age'),
        throwsA(isA<JsonFieldError>()),
      );
    });

    test('throws JsonFieldError when field is null without default', () {
      final json = {'age': null};

      expect(
        () => Guard.value<int>(json, 'age'),
        throwsA(isA<JsonFieldError>()),
      );
    });
  });

  group('Guard.valueOrNull', () {
    test('returns value when present and correct type', () {
      final json = {'name': 'Dave', 'age': 25};

      expect(Guard.valueOrNull<String>(json, 'name'), equals('Dave'));
      expect(Guard.valueOrNull<int>(json, 'age'), equals(25));
    });

    test('returns null when field is missing', () {
      final json = {'name': 'Eve'};

      expect(Guard.valueOrNull<int>(json, 'age'), isNull);
    });

    test('returns null when field is null', () {
      final json = {'age': null};

      expect(Guard.valueOrNull<int>(json, 'age'), isNull);
    });

    test('throws JsonFieldError when type mismatch', () {
      final json = {'age': '25'};

      expect(
        () => Guard.valueOrNull<int>(json, 'age'),
        throwsA(isA<JsonFieldError>()),
      );
    });
  });

  group('Guard.object', () {
    test('parses nested object successfully', () {
      final json = {
        'user': {'name': 'Frank', 'age': 35}
      };

      final user = Guard.object<Map>(json, 'user', (m) => m);

      expect(user['name'], equals('Frank'));
      expect(user['age'], equals(35));
    });

    test('throws JsonFieldError when field is not a Map', () {
      final json = {'user': 'not a map'};

      expect(
        () => Guard.object<Map>(json, 'user', (m) => m),
        throwsA(isA<JsonFieldError>()),
      );
    });

    test('throws JsonFieldError when field is missing', () {
      final json = {'name': 'Grace'};

      expect(
        () => Guard.object<Map>(json, 'user', (m) => m),
        throwsA(isA<JsonFieldError>()),
      );
    });
  });

  group('Guard.list', () {
    test('parses list of primitives successfully', () {
      final json = {
        'tags': ['dart', 'flutter', 'json']
      };

      final tags = Guard.list<String>(json, 'tags', (v) => v as String);

      expect(tags, equals(['dart', 'flutter', 'json']));
      expect(tags.length, equals(3));
    });

    test('parses list of objects successfully', () {
      final json = {
        'users': [
          {'name': 'Alice'},
          {'name': 'Bob'}
        ]
      };

      final users = Guard.list<Map>(json, 'users', (v) => v as Map);

      expect(users.length, equals(2));
      expect(users[0]['name'], equals('Alice'));
      expect(users[1]['name'], equals('Bob'));
    });

    test('throws JsonFieldError when field is not a List', () {
      final json = {'tags': 'not a list'};

      expect(
        () => Guard.list<String>(json, 'tags', (v) => v as String),
        throwsA(isA<JsonFieldError>()),
      );
    });

    test('throws JsonFieldError when field is missing', () {
      final json = {'name': 'Henry'};

      expect(
        () => Guard.list<String>(json, 'tags', (v) => v as String),
        throwsA(isA<JsonFieldError>()),
      );
    });
  });

  group('JsonGuardExt', () {
    test('guard extension works correctly', () {
      final json = {'name': 'Ivy', 'age': 28};

      expect(json.guard<String>('name'), equals('Ivy'));
      expect(json.guard<int>('age'), equals(28));
    });

    test('guard extension with default value', () {
      final json = {'name': 'Jack'};

      expect(json.guard<String>('role', defaultValue: 'admin'), equals('admin'));
    });

    test('guardOrNull extension works correctly', () {
      final json = {'name': 'Kate'};

      expect(json.guardOrNull<String>('name'), equals('Kate'));
      expect(json.guardOrNull<int>('age'), isNull);
    });

    test('guardList extension works correctly', () {
      final json = {
        'items': ['a', 'b', 'c']
      };

      final items = json.guardList<String>('items', (v) => v as String);
      expect(items, equals(['a', 'b', 'c']));
    });

    test('guardObject extension works correctly', () {
      final json = {
        'config': {'debug': true}
      };

      final config = json.guardObject<Map>('config', (m) => m);
      expect(config['debug'], isTrue);
    });
  });

  group('JsonFieldError', () {
    test('contains correct error information', () {
      final error = JsonFieldError(
        key: 'age',
        expected: int,
        received: '30',
      );

      expect(error.key, equals('age'));
      expect(error.expected, equals(int));
      expect(error.received, equals('30'));
    });

    test('toString includes all error details', () {
      final error = JsonFieldError(
        key: 'age',
        expected: int,
        received: '30',
      );

      final errorString = error.toString();
      expect(errorString, contains('age'));
      expect(errorString, contains('int'));
      expect(errorString, contains('String'));
    });
  });

  group('Guard debug mode', () {
    test('debug mode can be toggled', () {
      Guard.setDebugLogging(true);
      expect(Guard.debug, isTrue);

      Guard.setDebugLogging(false);
      expect(Guard.debug, isFalse);
    });
  });

  group('GuardTheme', () {
    test('theme can be customized', () {
      GuardTheme.setTheme(
        errorPrefix: 'CUSTOM ERROR:',
        fieldLabel: 'Field Name',
        expectedLabel: 'Expected Type',
        receivedLabel: 'Received Type',
      );

      expect(GuardTheme.errorPrefix, equals('CUSTOM ERROR:'));
      expect(GuardTheme.fieldLabel, equals('Field Name'));
      expect(GuardTheme.expectedLabel, equals('Expected Type'));
      expect(GuardTheme.receivedLabel, equals('Received Type'));
    });
  });

  group('Integration tests', () {
    test('complex nested structure parsing', () {
      final json = {
        'user': {
          'name': 'Leo',
          'age': 30,
          'email': 'leo@example.com',
        },
        'tags': ['developer', 'dart'],
        'active': true,
      };

      expect(json.guardObject<Map>('user', (m) => m)['name'], equals('Leo'));
      expect(json.guardList<String>('tags', (v) => v as String).length,
          equals(2));
      expect(json.guard<bool>('active'), isTrue);
    });

    test('handles mixed optional and required fields', () {
      final json = {
        'name': 'Mia',
        'age': 25,
      };

      expect(json.guard<String>('name'), equals('Mia'));
      expect(json.guard<int>('age'), equals(25));
      expect(json.guardOrNull<String>('email'), isNull);
      expect(json.guard<String>('role', defaultValue: 'user'), equals('user'));
    });
  });
}
