import 'package:x_flutter_core/src/data/local/base/key_value_storage.dart';

abstract class KeyValueReloadableStorage<T> extends KeyValueStorage<T> {
  Future<void> reload();
}
