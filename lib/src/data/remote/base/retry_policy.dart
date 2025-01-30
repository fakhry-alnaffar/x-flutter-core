import 'dart:async';

abstract class RetryPolicy {
  final int maxAttemptsCount;
  final List<int> retryStatusCodes;

  RetryPolicy({
    required this.maxAttemptsCount,
    required this.retryStatusCodes,
  });

  FutureOr<bool> onRetry({
    required Exception exception,
  });
}
