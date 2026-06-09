// ignore_for_file: prefer_initializing_formals
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:onix_flutter_core/src/data/remote/base/base_api_client.dart';
import 'package:onix_flutter_core/src/data/remote/dio/interceptor/cache_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient implements BaseApiClient<Dio> {
  final List<Interceptor> _interceptors;
  CacheInterceptor? _cacheInterceptor;
  @override
  late Dio client;

  CacheOptions? get cacheOptions => _cacheInterceptor?.cacheOptions;

  ApiClient({
    required BaseOptions options,
    List<Interceptor> interceptors = const [],
  }) : _interceptors = List.from(interceptors) {
    client = Dio(options);
    client.transformer = BackgroundTransformer();
    _initInterceptors();
  }

  void _initInterceptors() {
    attachLoggerInterceptor();
    attachInterceptors();
  }

  void updateClientBaseUrl(String baseUrl) {
    client.options = client.options.copyWith(baseUrl: baseUrl);
  }

  @override
  void attachLoggerInterceptor() {
    if (kDebugMode) {
      final hasLogger = client.interceptors.any((i) => i is PrettyDioLogger);
      if (!hasLogger) {
        client.interceptors.add(
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseHeader: true,
            compact: false,
          ),
        );
      }
    }
  }

  @override
  void attachInterceptors() {
    for (final interceptor in _interceptors) {
      if (!client.interceptors.contains(interceptor)) {
        client.interceptors.add(interceptor);
      }
    }
    if (_cacheInterceptor != null) {
      _reAttachCacheInterceptor();
    }
  }

  @override
  void attachCacheInterceptor(CacheInterceptor cacheInterceptor) {
    _cacheInterceptor = cacheInterceptor;
    _reAttachCacheInterceptor();
  }

  @override
  void detachInterceptors() {
    client.interceptors.clear();
    if (_cacheInterceptor != null) {
      clearCache();
    }
    attachLoggerInterceptor();
  }

  void attachCharlesProxy(String? charlesIp, String? port) {
    if (charlesIp == null || port == null) return;
    client.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient()
          ..findProxy = (uri) => 'PROXY $charlesIp:$port';

        //ignore: cascade_invocations
        client.badCertificateCallback = (cert, host, port) => true;

        return client;
      },
    );
  }

  CachePolicy getCachePolicy({required bool forceRefresh}) =>
      _cacheInterceptor?.getCachePolicy(forceRefresh: forceRefresh) ??
      CachePolicy.noCache;

  Future<void> clearCache() async {
    await _cacheInterceptor?.clearCache();
    await _reAttachCacheInterceptor();
  }

  String customCacheKeyBuilder(RequestOptions request) =>
      _cacheInterceptor?.customCacheKeyBuilder(request) ?? '';

  Future<void> _reAttachCacheInterceptor() async {
    _cacheInterceptor?.detachInterceptor();
    await _cacheInterceptor?.attachCacheInterceptor();
  }
}
