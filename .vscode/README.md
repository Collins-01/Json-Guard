# JSON Type Guard - VS Code Snippets

This folder contains VS Code snippets to help you work faster with `json_type_guard`.

## Installation

### Option 1: Copy to User Snippets (Recommended)
1. Open VS Code
2. Press `Cmd+Shift+P` (Mac) or `Ctrl+Shift+P` (Windows/Linux)
3. Type "Preferences: Configure User Snippets"
4. Select "dart.json"
5. Copy the contents of `json_type_guard.code-snippets` into the file

### Option 2: Use Workspace Snippets
The snippets in this folder will automatically work in this workspace.

## Available Snippets

| Prefix | Description |
|--------|-------------|
| `jtg-import` | Import json_type_guard package |
| `jtg-model` | Create a basic model with fromJson |
| `jtg-model-full` | Create a complete model with multiple field types |
| `jtg-field` | Add a required field |
| `jtg-field-opt` | Add an optional field |
| `jtg-parse` | Parse a required field |
| `jtg-parse-opt` | Parse an optional field |
| `jtg-parse-default` | Parse a field with default value |
| `jtg-parse-object` | Parse a nested object |
| `jtg-parse-list` | Parse a list of primitives |
| `jtg-parse-list-obj` | Parse a list of objects |
| `jtg-try` | Try-catch block for JSON parsing |
| `jtg-theme` | Set custom error theme |
| `jtg-debug` | Toggle debug logging |

## Usage Examples

### Quick Model Creation
Type `jtg-model` and press Tab:
```dart
class User {
  final String name;

  User.fromJson(Map json)
      : name = json.guard<String>('name');

  @override
  String toString() => 'User(name: $name)';
}
```

### Add Fields
Type `jtg-parse` in the constructor initializer list:
```dart
fieldName = json.guard<String>('fieldName')
```

### Parse Nested Objects
Type `jtg-parse-object`:
```dart
address = json.guardObject<Address>('address', Address.fromJson)
```

### Parse Lists
Type `jtg-parse-list`:
```dart
tags = json.guardList<String>('tags', (v) => v as String)
```

## Tips

- All snippets start with `jtg-` prefix for easy discovery
- Use Tab to navigate between placeholder fields
- Press Tab again to move to the next field
- Press Escape to exit snippet mode

## Feedback

Found a bug or have a suggestion? Open an issue on [GitHub](https://github.com/Collins-01/Json-Guard/issues).
