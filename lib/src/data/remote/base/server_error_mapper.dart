import 'package:flutter/foundation.dart';
import 'package:onix_flutter_core/src/domain/entity/common/data_response.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';

abstract class ServerErrorMapper {

  Failure? onCustomError(
    Object data,
    int? statusCode,
  );

  Failure mapToFailure<T>(
    DataResponse<T> failure,
  ) {
    try {
      return failure.maybeWhen(
        undefinedError: (error, statusCode) => ApiUndefinedFailure(
          statusCode: statusCode,
          message: error.toString(),
        ),
        apiError: (error, statusCode) {
          final customError = onCustomError(error, statusCode);
          return customError ??
              ApiFailure(
                ServerFailure.response,
                statusCode: statusCode,
                message: error.toString(),
              );
        },
        notConnected: ConnectionFailure.new,
        unauthorized: ApiUnauthorizedFailure.new,
        tooManyRequests: ApiTooManyRequestsFailure.new,
        canceledRequest: CanceledRequestFailure.new,
        orElse: ApiUnknownFailure.new,
      );
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
