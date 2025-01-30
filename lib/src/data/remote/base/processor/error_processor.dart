import 'package:onix_flutter_core/src/data/remote/dio/internal_dio_error_processor.dart';
import 'package:onix_flutter_core/src/domain/entity/common/data_response.dart';

typedef OnCustomError<T> = Object Function(
  int statusCode,
  dynamic response,
);

abstract class ErrorProcessor {
  factory ErrorProcessor.internal() => const InternalDioErrorProcessor();

  DataResponse<T> processError<T>(
    Exception e, {
    OnCustomError? onCustomError,
  });
}
