import 'package:onix_flutter_core/src/domain/entity/common/data_response.dart';

typedef OnCustomError<T> = Object Function(
  int statusCode,
  dynamic response,
);

abstract class ErrorProcessor {
  DataResponse<T> processError<T>(
    Exception e, {
    OnCustomError? onCustomError,
  });
}
