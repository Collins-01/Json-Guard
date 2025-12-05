# 🛡️ json_type_guard  
### *Protector of Models. Warden of Types. Keeper of the Seven JSON Kingdoms.*

A tiny, zero-codegen, runtime-safe JSON parsing helper for Dart & Flutter.  
Stop guessing which field broke your `.fromJson`.  
Stop seeing *“Null is not a subtype of…”* with no clue where it came from.

`json_type_guard` gives you **precise, field-level errors**, safe parsing, optional fields, defaults, and full type validation — all without build runners, annotations, or boilerplate.

---

## 🚀 Features

- 🛡️ Runtime type-safe JSON access  
- 🔎 Clear, explicit error messages  
- ❌ No code generation  
- 🧩 No annotations  
- 🎯 Zero boilerplate  
- 👀 Detects wrong data types per field  
- 🔄 Fallback/default value support  
- ❓ Optional fields & nullable types  
- 📚 Supports all Dart types  
- 🧱 Consistent & predictable API  

---

## 📦 Installation

```yaml
dependencies:
  json_type_guard: ^1.0.0
```

---

## 🎯 Quick Start

```dart
import 'package:json_type_guard/json_type_guard.dart';

class User {
  final String name;
  final int age;
  final String? email;
  final String role;

  User.fromJson(Map json)
      : name = json.guard<String>("name"),
        age = json.guard<int>("age"),
        email = json.guardOrNull<String>("email"),
        role = json.guard<String>("role", defaultValue: "user");
}

void main() {
  final json = {
    'name': 'Alice',
    'age': 30,
    'email': 'alice@example.com',
  };
  
  final user = User.fromJson(json);
  print(user.name); // Alice
}
```

---

## 📖 Usage

### Basic Type Extraction

```dart
final json = {'name': 'Bob', 'age': 25};

// Required fields
final name = json.guard<String>('name');
final age = json.guard<int>('age');
```

### Optional Fields

```dart
// Returns null if missing or null
final email = json.guardOrNull<String>('email');
```

### Default Values

```dart
// Uses default if field is missing
final role = json.guard<String>('role', defaultValue: 'user');
```

### Nested Objects

```dart
class Address {
  final String city;
  Address.fromJson(Map json) : city = json.guard<String>('city');
}

class Person {
  final String name;
  final Address address;

  Person.fromJson(Map json)
      : name = json.guard<String>('name'),
        address = json.guardObject<Address>('address', Address.fromJson);
}
```

### Lists

```dart
// List of primitives
final tags = json.guardList<String>('tags', (v) => v as String);

// List of objects
final users = json.guardList<User>('users', (v) => User.fromJson(v as Map));
```

---

## 🚨 Error Handling

When parsing fails, you get **precise, readable errors**:

```dart
final json = {'name': 'Charlie', 'age': '30'}; // age is String, not int

try {
  final user = User.fromJson(json);
} catch (e) {
  print(e);
  // Output:
  // JsonGuardError:
  //   Field: "age"
  //   Expected: int
  //   Received: String (30)
}
```

### Custom Error Themes

```dart
import 'package:json_type_guard/json_type_guard.dart';

GuardTheme.setTheme(
  errorPrefix: '🚨 CUSTOM ERROR:',
  fieldLabel: '📍 Field',
  expectedLabel: '🎯 Expected',
  receivedLabel: '📦 Received',
);
```

---

## 🔧 API Reference

### Guard Methods

| Method | Description |
|--------|-------------|
| `guard<T>(key, {defaultValue})` | Extract required field with optional default |
| `guardOrNull<T>(key)` | Extract optional/nullable field |
| `guardObject<T>(key, builder)` | Parse nested object |
| `guardList<T>(key, convert)` | Parse list with converter |

### Static Methods

```dart
// Use Guard class directly
Guard.value<String>(json, 'name');
Guard.valueOrNull<int>(json, 'age');
Guard.object<Address>(json, 'address', Address.fromJson);
Guard.list<String>(json, 'tags', (v) => v as String);
```

### Debug Mode

```dart
Guard.setDebugLogging(true);  // Enable debug logs
Guard.setDebugLogging(false); // Disable debug logs
```

---

## 🆚 Comparison

| Feature | json_type_guard | json_serializable | Manual parsing |
|---------|-----------|-------------------|----------------|
| Code generation | ❌ | ✅ | ❌ |
| Build runner | ❌ | ✅ | ❌ |
| Annotations | ❌ | ✅ | ❌ |
| Clear errors | ✅ | ❌ | ❌ |
| Runtime safety | ✅ | ✅ | ❌ |
| Setup time | Instant | Minutes | Instant |
| Boilerplate | Minimal | Medium | High |

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---

## 📄 License

MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🌟 Show Your Support

If you find this package helpful, please give it a ⭐ on [GitHub](https://github.com/Collins-01/Json-Guard)!
