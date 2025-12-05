import 'package:json_guard/json_guard.dart';
import 'package:json_guard/src/extensions.dart';

class User {
  final String name;
  final int age;

  User.fromJson(Map json)
    : name = json.guard<String>("name", defaultValue: "Collins"),
      age = json.guard<int>("age");
}

void main() {
  var awesome = Awesome();
  print('awesome: ${awesome.isAwesome}');
}
