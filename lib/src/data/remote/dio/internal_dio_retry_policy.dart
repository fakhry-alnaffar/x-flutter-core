import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:onix_flutter_core/src/data/remote/base/retry_policy.dart';

class InternalDioRetryPolicy extends RetryPolicy {
  InternalDioRetryPolicy({
    required super.maxAttemptsCount,
    required super.retryStatusCodes,
  });

  @override
  FutureOr<bool> onRetry({
    required Exception exception,
  }) async {
    if (exception is! DioException) return false;
    if (exception.type == DioExceptionType.cancel) return false;
    final response = exception.response;
    if (response == null) {
      return true;
    }
    if (exception is SocketException || exception is TimeoutException) {
      return true;
    }
    return retryStatusCodes.contains(response.statusCode);
  }
}
