import 'package:example/base_api_client_example/data/model/default_api_error.dart';
import 'package:example/base_api_client_example/data/model/validation_api_error.dart';
import 'package:onix_flutter_core/onix_flutter_core.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';

class DioServerErrorMapper extends ServerErrorMapper {
  static final DioServerErrorMapper _singleton =
      DioServerErrorMapper._internal();

  factory DioServerErrorMapper() {
    return _singleton;
  }

  DioServerErrorMapper._internal();

  @override
  Failure? onCustomError(Object data, int? statusCode) {
    switch (data) {
      case (DefaultApiError defaultError):
        {
          return ApiFailure(
            ServerFailure.response,
            statusCode: statusCode,
            message: defaultError.message ?? '',
          );
        }
      case (ValidatorApiError validatorError):
        {
          return ApiFailure(
            ServerFailure.response,
            statusCode: statusCode,
            message: validatorError.validatorMessages?.join('\n') ?? '',
          );
        }
    }
    return ApiUnknownFailure();
  }
}
