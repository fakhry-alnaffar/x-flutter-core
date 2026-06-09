import 'package:flutter/foundation.dart';
import 'package:onix_flutter_core/src/domain/entity/common/data_response.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';

abstract class ServerErrorMapper {
  Failure? onCustomError(
    Object data,
    int? statusCode,
  );

  Failure mapToFailure<T>(
    DataResponse<T> response,
  ) {
    try {
      return switch (response) {
        DataResponseSuccess() => ApiUnknownFailure(),
        UndefinedError(:final errorObject, :final statusCode) =>
          ApiUndefinedFailure(
            statusCode: statusCode,
            message: errorObject.toString(),
          ),
        ApiError(:final error, :final statusCode) =>
          onCustomError(error, statusCode) ??
              ApiFailure(
                ServerFailure.response,
                statusCode: statusCode,
                message: error.toString(),
              ),
        NoInternetConnection() => ConnectionFailure(),
        Unauthorized() => ApiUnauthorizedFailure(),
        TooManyRequests() => ApiTooManyRequestsFailure(),
        CanceledRequest() => const CanceledRequestFailure(),
      };
    } catch (e, trace) {
      if (kDebugMode) {
        print('MapCommonServerError::getServerFailureDetails');
        print(e);
        print(trace);
      }
      return ApiExceptionFailure(message: e.toString());
    }
  }
}
