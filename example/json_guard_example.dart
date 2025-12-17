import 'dart:developer';

import 'package:json_type_guard/json_type_guard.dart';

// Example 1: Basic User model
class User {
  final String name;
  final int age;
  final String? email; // Optional field
  final String role;

  User.fromJson(Map json)
      : name = json.guard<String>("name"),
        age = json.guard<int>("age"),
        email = json.guardOrNull<String>("email"),
        role = json.guard<String>("role", defaultValue: "user");

  @override
  String toString() => 'User(name: $name, age: $age, email: $email, role: $role)';
}

// Example 2: Nested objects
class Address {
  final String street;
  final String city;
  final int zipCode;

  Address.fromJson(Map json)
      : street = json.guard<String>("street"),
        city = json.guard<String>("city"),
        zipCode = json.guard<int>("zipCode");

  @override
  String toString() => 'Address(street: $street, city: $city, zip: $zipCode)';
}

class Person {
  final String name;
  final Address address;

  Person.fromJson(Map json)
      : name = json.guard<String>("name"),
        address = json.guardObject<Address>("address", Address.fromJson);

  @override
  String toString() => 'Person(name: $name, address: $address)';
}

// Example 3: Lists
class Team {
  final String name;
  final List<String> members;
  final List<User> users;

  Team.fromJson(Map json)
      : name = json.guard<String>("name"),
        members = json.guardList<String>("members", (v) => v as String),
        users = json.guardList<User>("users", (v) => User.fromJson(v as Map));

  @override
  String toString() => 'Team(name: $name, members: $members, users: $users)';
}

void main() {
  log('�️ JSONO Guard Examples\n');

  // Example 1: Basic usage with valid data
  log('═══ Example 1: Basic User ═══');
  try {
    final userJson = {
      'name': 'Alice',
      'age': 30,
      'email': 'alice@example.com',
    };
    final user = User.fromJson(userJson);
    log('✅ Success: $user\n');
  } catch (e) {
    log('❌ Error: $e\n');
  }

  // Example 2: Missing optional field (should work)
  log('═══ Example 2: Missing Optional Field ═══');
  try {
    final userJson = {
      'name': 'Bob',
      'age': 25,
      // email is missing but optional
    };
    final user = User.fromJson(userJson);
    log('✅ Success: $user\n');
  } catch (e) {
    log('❌ Error: $e\n');
  }

  // Example 3: Default value
  log('═══ Example 3: Default Value ═══');
  try {
    final userJson = {
      'name': 'Charlie',
      'age': 28,
      // role is missing, should use default "user"
    };
    final user = User.fromJson(userJson);
    log('✅ Success: $user\n');
  } catch (e) {
    log('❌ Error: $e\n');
  }

  // Example 4: Type mismatch error
  log('═══ Example 4: Type Mismatch (Expected Error) ═══');
  try {
    final userJson = {
      'name': 'Dave',
      'age': '30', // Wrong type: String instead of int
    };
    final user = User.fromJson(userJson);
    log('✅ Success: $user\n');
  } catch (e) {
    log('❌ Error: $e');
  }

  // Example 5: Missing required field
  log('═══ Example 5: Missing Required Field (Expected Error) ═══');
  try {
    final userJson = {
      'name': 'Eve',
      // age is missing and required
    };
    final user = User.fromJson(userJson);
    log('✅ Success: $user\n');
  } catch (e) {
    log('❌ Error: $e');
  }

  // Example 6: Nested objects
  log('═══ Example 6: Nested Objects ═══');
  try {
    final personJson = {
      'name': 'Frank',
      'address': {
        'street': '123 Main St',
        'city': 'Springfield',
        'zipCode': 12345,
      }
    };
    final person = Person.fromJson(personJson);
    log('✅ Success: $person\n');
  } catch (e) {
    log('❌ Error: $e\n');
  }

  // Example 7: Lists
  log('═══ Example 7: Lists ═══');
  try {
    final teamJson = {
      'name': 'Dev Team',
      'members': ['Alice', 'Bob', 'Charlie'],
      'users': [
        {'name': 'Alice', 'age': 30},
        {'name': 'Bob', 'age': 25},
      ]
    };
    final team = Team.fromJson(teamJson);
    log('✅ Success: $team\n');
  } catch (e) {
    log('❌ Error: $e\n');
  }

  // Example 8: Custom theme
  log('═══ Example 8: Custom Theme ═══');
  GuardTheme.setTheme(
    errorPrefix: '🚨 CUSTOM ERROR:',
    fieldLabel: '📍 Field',
    expectedLabel: '🎯 Expected',
    receivedLabel: '📦 Received',
  );
  try {
    final userJson = {
      'name': 'Grace',
      'age': false, // Wrong type
    };
    final user = User.fromJson(userJson);
    log('✅ Success: $user\n');
  } catch (e) {
    log('❌ Error: $e');
  }

  // Example 9: Enable colors (for terminal output)
  log('═══ Example 9: Enable Colors ═══');
  GuardTheme.enableColors(); // Enable ANSI colors for terminals
  try {
    final userJson = {
      'name': 'Henry',
      'age': 'not a number', // Wrong type
    };
    final user = User.fromJson(userJson);
    log('✅ Success: $user\n');
  } catch (e) {
    log('❌ Error with colors: $e');
  }
  GuardTheme.disableColors(); // Disable colors again

  // Example 10: Debug logging
  log('═══ Example 10: Debug Mode ═══');
  Guard.setDebugLogging(true);
  log('Debug mode enabled: ${Guard.debug}');
  Guard.setDebugLogging(false);
  log('Debug mode disabled: ${Guard.debug}\n');

  log('🎉 All examples completed!');
}
