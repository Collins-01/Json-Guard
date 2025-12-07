import 'lib/src/guard.dart';

void main() {
  print('=== DateTime Parsing Demo ===\n');

  // Test 1: ISO8601 string
  print('Test 1: ISO8601 DateTime string');
  final json1 = {'created_at': '2024-12-07T10:30:00Z'};
  final date1 = Guard.dateTime(json1, 'created_at');
  print('Input: ${json1['created_at']}');
  print('Parsed: $date1');
  print('');

  // Test 2: Date-only ISO8601
  print('Test 2: Date-only ISO8601 string');
  final json2 = {'date': '2024-12-07'};
  final date2 = Guard.dateTime(json2, 'date');
  print('Input: ${json2['date']}');
  print('Parsed: $date2');
  print('');

  // Test 3: Unix timestamp (seconds)
  print('Test 3: Unix timestamp in seconds');
  final json3 = {'timestamp': 1701950400};
  final date3 = Guard.dateTime(json3, 'timestamp');
  print('Input: ${json3['timestamp']} (seconds)');
  print('Parsed: $date3');
  print('');

  // Test 4: Unix timestamp (milliseconds)
  print('Test 4: Unix timestamp in milliseconds');
  final json4 = {'timestamp': 1701950400000};
  final date4 = Guard.dateTime(json4, 'timestamp');
  print('Input: ${json4['timestamp']} (milliseconds)');
  print('Parsed: $date4');
  print('');

  // Test 5: Optional DateTime (missing)
  print('Test 5: Optional DateTime (missing field)');
  final json5 = {'name': 'Event'};
  final date5 = Guard.dateTimeOrNull(json5, 'updated_at');
  print('Input: field missing');
  print('Result: $date5');
  print('');

  // Test 6: Optional DateTime (present)
  print('Test 6: Optional DateTime (present)');
  final json6 = {'updated_at': '2024-12-07T15:45:00Z'};
  final date6 = Guard.dateTimeOrNull(json6, 'updated_at');
  print('Input: ${json6['updated_at']}');
  print('Parsed: $date6');
  print('');

  // Test 7: Error - Invalid format
  print('Test 7: Error handling - Invalid date format');
  final json7 = {'date': 'not-a-date'};
  try {
    Guard.dateTime(json7, 'date');
  } catch (e) {
    print('Input: ${json7['date']}');
    print('Error: $e');
  }
  print('');

  // Test 8: Error - Wrong type
  print('Test 8: Error handling - Wrong type');
  final json8 = {'date': true};
  try {
    Guard.dateTime(json8, 'date');
  } catch (e) {
    print('Input: ${json8['date']} (bool)');
    print('Error: $e');
  }
  print('');

  print('=== Demo Complete ===');
  print('\nDateTime parsing supports:');
  print('  ✅ ISO8601 strings (full or date-only)');
  print('  ✅ Unix timestamps (seconds)');
  print('  ✅ Unix timestamps (milliseconds)');
  print('  ✅ Auto-format detection');
  print('  ✅ Optional DateTime fields');
  print('  ✅ Clear error messages');
}
