import 'lib/src/errors/json_field_error.dart';

void main() {
  print('=== Testing JsonFieldError toString() output ===\n');

  // Test 1: String expected, int received
  final error1 = JsonFieldError(
    key: 'username',
    expected: String,
    received: 123,
  );
  print('Test 1: String expected, int received');
  print(error1.toString());
  print('');

  // Test 2: int expected, String received
  final error2 = JsonFieldError(
    key: 'age',
    expected: int,
    received: 'twenty-five',
  );
  print('Test 2: int expected, String received');
  print(error2.toString());
  print('');

  // Test 3: List expected, null received
  final error3 = JsonFieldError(key: 'items', expected: List, received: null);
  print('Test 3: List expected, null received');
  print(error3.toString());
  print('');

  // Test 4: Map expected, bool received
  final error4 = JsonFieldError(
    key: 'user_data',
    expected: Map,
    received: true,
  );
  print('Test 4: Map expected, bool received');
  print(error4.toString());
}
