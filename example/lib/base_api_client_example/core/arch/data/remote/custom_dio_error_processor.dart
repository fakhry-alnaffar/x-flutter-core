import 'package:dio/dio.dart';
import 'package:onix_flutter_core/onix_flutter_core.dart';

class CustomDioErrorProcessor implements DioErrorProcessor {
  @override
  DataResponse<T> processError<T>(DioException e,
      {OnCustomError? onCustomError}) {
    final statusCode = e.response?.statusCode ?? -1;

    if (onCustomError != null) {
      final apiError = onCustomError(e.response);
      return DataResponse<T>.apiError(apiError, statusCode);
    }

    print('Error $statusCode: $e');
    return DataResponse<T>.undefinedError(e, statusCode);
  }
}
