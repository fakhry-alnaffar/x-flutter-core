import 'package:x_flutter_core/src/data/local/base/key_value_storage.dart';

/// A [KeyValueStorage] that supports refreshing its in-memory state from disk.
///
/// Useful for [SharedPreferences]-backed storage where another isolate or
/// process may have written new values since the last read.
abstract class KeyValueReloadableStorage<T> extends KeyValueStorage<T> {
  /// Reloads the underlying storage, picking up any external changes.
  Future<void> reload();
}
