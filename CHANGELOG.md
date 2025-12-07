## 1.0.2

- **New Feature**: Path tracking in error messages
  - Error messages now show full path to fields in nested structures (e.g., `"user.profile.email"`)
  - Makes debugging deeply nested JSON significantly easier
  - Optional `path` parameter added to all Guard methods
  - Fully backward compatible - existing code works unchanged
- Added 7 comprehensive tests for path tracking
- All 34 tests passing

## 1.0.1

- Updated documentation and examples
- Added comprehensive test suite
- Improved error messages with theming support

## 1.0.0

- Initial release
- Runtime type-safe JSON parsing
- Clear, field-level error messages
- Support for optional fields with `guardOrNull`
- Default value support
- Nested object parsing with `guardObject`
- List parsing with `guardList`
- Custom error theming
- Debug mode toggle
- Zero dependencies
- No code generation required
- Full test coverage
