import 'package:flutter/foundation.dart';

abstract class KeyValueStorage<T> {
  Future<T>? _initFuture;

  @protected
  Future<T> storage() => _initFuture ??= create();

  @protected
  Future<T> create();

  Future<K> get<K>(String key, K defaultValue);

  Future<void> put<K>(String key, K value);

  Future<void> clear();

  Future<bool> remove(String key);

  Future<bool> contains(String key);
}
