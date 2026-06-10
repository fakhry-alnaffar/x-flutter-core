import 'package:x_flutter_core/src/data/remote/base/cache_interceptor.dart';

abstract class BaseApiClient<T> {
  static const String kAuthHeader = 'Authorization';
  static const String kAuthPrefix = 'Bearer ';
  static const String kAcceptHeader = 'Accept';
  static const String kContentTypeHeader = 'Content-Type';
  static const String kJsonPrefix = 'application/json';
  static const String kMultipartPrefix = 'multipart/form-data';
  static const String kMediaJPEG = 'image/jpeg';
  static const String kMediaPNG = 'image/png';

  late T client;

  Future<void> attachInterceptors();

  Future<void> attachCacheInterceptor(CacheInterceptor cacheInterceptor);

  Future<void> detachInterceptors();

  void attachLoggerInterceptor();
}
