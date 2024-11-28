import 'package:flutter/foundation.dart';
import 'package:onix_flutter_core/src/domain/entity/common/data_response.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';

abstract class ServerErrorMapper {
  Exception? onCustomError(
    Object data,
    int? statusCode,
  );

  Exception mapToFailure<T>(
    DataResponse<T> failure,
  ) {
    try {
      switch (failure) {
        case UndefinedError u:
          {
            return ApiUndefinedFailure(
              statusCode: u.statusCode,
              message: u.errorObject.toString(),
            );
          }
        case ApiError e:
          {
            final customError = onCustomError(
              e.error,
              e.statusCode,
            );
            return customError ??
                ApiFailure(
                  ServerFailure.response,
                  statusCode: e.statusCode,
                  message: e.error.toString(),
                );
          }
        case NoInternetConnection _:
          {
            return ConnectionFailure();
          }
        case Unauthorized _:
          {
            return ApiUnauthorizedFailure();
          }
        case TooManyRequests _:
          {
            return ApiTooManyRequestsFailure();
          }
        case CanceledRequest _:
          {
            return const CanceledRequestFailure();
          }
      }
      return ApiUnknownFailure();
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
