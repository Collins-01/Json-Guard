import 'lib/src/guard.dart';

void main() {
  print('=== Path Tracking Demo ===\n');

  // Test 1: Simple field error
  print('Test 1: Simple field error');
  try {
    final json = {'age': 'not a number'};
    Guard.value<int>(json, 'age');
  } catch (e) {
    print(e);
  }
  print('');

  // Test 2: Nested object error
  print('Test 2: Nested object error (user.profile.email)');
  try {
    final json = {
      'user': {
        'profile': {'email': 12345},
      },
    };
    final user = json['user'] as Map;
    final profile = user['profile'] as Map;
    Guard.value<String>(profile, 'email', path: 'user.profile');
  } catch (e) {
    print(e);
  }
  print('');

  // Test 3: Deeply nested structure
  print(
    'Test 3: Deeply nested structure (company.departments.engineering.manager.name)',
  );
  try {
    final json = {
      'company': {
        'departments': {
          'engineering': {
            'manager': {'name': true},
          },
        },
      },
    };
    final company = json['company'] as Map;
    final departments = company['departments'] as Map;
    final engineering = departments['engineering'] as Map;
    final manager = engineering['manager'] as Map;
    Guard.value<String>(
      manager,
      'name',
      path: 'company.departments.engineering.manager',
    );
  } catch (e) {
    print(e);
  }
  print('');

  // Test 4: List error
  print('Test 4: List error (data.items)');
  try {
    final json = {
      'data': {'items': 'not a list'},
    };
    final data = json['data'] as Map;
    Guard.list<String>(data, 'items', (v) => v as String, path: 'data');
  } catch (e) {
    print(e);
  }
  print('');

  // Test 5: Object error in nested structure
  print('Test 5: Object error (settings.database.config)');
  try {
    final json = {
      'settings': {
        'database': {'config': 'should be a map'},
      },
    };
    final settings = json['settings'] as Map;
    final database = settings['database'] as Map;
    Guard.object<Map>(database, 'config', (m) => m, path: 'settings.database');
  } catch (e) {
    print(e);
  }
  print('');

  print('=== Demo Complete ===');
  print(
    '\nNotice how each error shows the FULL PATH to the problematic field!',
  );
  print('This makes debugging nested JSON structures much easier. 🎯');
}
