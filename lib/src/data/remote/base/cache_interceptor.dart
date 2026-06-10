import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

abstract interface class CacheInterceptor {
  CacheOptions? cacheOptions;

  Future<void> attachCacheInterceptor();

  Future<CacheOptions> createOptions();

  CachePolicy getCachePolicy({required bool forceRefresh});

  Future<void> clearCache();

  void detachInterceptor();

  String customCacheKeyBuilder(RequestOptions request);
}
