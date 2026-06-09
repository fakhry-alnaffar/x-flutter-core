sealed class DataResponse<T> {
  const DataResponse();

  T get data {
    if (this is DataResponseSuccess<T>) {
      return (this as DataResponseSuccess<T>).data;
    }
    throw StateError('Cannot access data on a non-success response: $this');
  }

  bool isSuccess() => this is DataResponseSuccess<T>;

  bool isError() => this is! DataResponseSuccess<T>;

  factory DataResponse.success(T data) => DataResponseSuccess(data);

  factory DataResponse.undefinedError(
    Object? errorObject, [
    int? statusCode,
  ]) =>
      UndefinedError(
        errorObject,
        statusCode,
      );

  factory DataResponse.apiError(
    Object error, [
    int? statusCode,
  ]) =>
      ApiError(
        error,
        statusCode,
      );

  factory DataResponse.notConnected() => NoInternetConnection();

  factory DataResponse.unauthorized() => Unauthorized();

  factory DataResponse.tooManyRequests() => TooManyRequests();

  factory DataResponse.canceledRequest() => CanceledRequest();
}

final class DataResponseSuccess<T> extends DataResponse<T> {
  final T _data;

  @override
  T get data => _data;

  const DataResponseSuccess(T data) : _data = data;
}

final class UndefinedError<T> extends DataResponse<T> {
  final Object? _errorObject;
  final int? _statusCode;

  Object? get errorObject => _errorObject;

  int? get statusCode => _statusCode;

  const UndefinedError(
    Object? errorObject, [
    int? statusCode,
  ])  : _errorObject = errorObject,
        _statusCode = statusCode;
}

final class ApiError<T> extends DataResponse<T> {
  final Object _error;
  final int? _statusCode;

  Object get error => _error;

  int? get statusCode => _statusCode;

  const ApiError(
    Object error, [
    int? statusCode,
  ])  : _error = error,
        _statusCode = statusCode;
}

final class NoInternetConnection<T> extends DataResponse<T> {
  const NoInternetConnection();
}

final class Unauthorized<T> extends DataResponse<T> {
  const Unauthorized();
}

final class TooManyRequests<T> extends DataResponse<T> {
  const TooManyRequests();
}

final class CanceledRequest<T> extends DataResponse<T> {
  const CanceledRequest();
}
