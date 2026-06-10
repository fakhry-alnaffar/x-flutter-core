/// x_flutter_core — networking, storage, and infrastructure for Flutter.
///
/// Provides a Dio-based HTTP client with caching, retry, and proxy support,
/// a clean-architecture request/error processor pipeline, secure and shared
/// preferences storage, and connectivity checking utilities.
///
/// ## Quick start
/// ```dart
/// final module = _MyDioModule();
/// final client = module.makeApiClient(ApiClientParams(
///   baseUrl: 'https://api.example.com/',
///   defaultConnectTimeout: 5000,
///   defaultReceiveTimeout: 5000,
/// ));
/// final processor = module.createInternalDioRequestProcessor();
/// ```
library;

export 'src/data/local/prefs/shared_preferences_storage.dart';
export 'src/data/local/prefs/secured_preferences_storage.dart';
export 'src/data/local/base/key_value_storage.dart';
export 'src/data/local/base/key_value_reloadable_storage.dart';
export 'src/data/remote/base/base_api_client.dart' show BaseApiClient;
export 'src/data/remote/base/http_status.dart' show HttpStatus;
export 'src/data/remote/base/server_error_mapper.dart' show ServerErrorMapper;
export 'src/data/remote/base/connection_checker.dart';
export 'src/data/remote/dio/api_client.dart' show ApiClient;
export 'src/data/remote/dio/dio_client_module.dart' show DioClientModule;

export 'src/data/remote/base/processor/request_processor.dart'
    show RequestProcessor, OnRequest, OnParse;
export 'src/data/remote/dio/internal_dio_request_processor.dart'
    show InternalDioRequestProcessor;
export 'src/data/remote/base/processor/error_processor.dart'
    show ErrorProcessor, OnCustomError;
export 'src/data/remote/dio/internal_dio_error_processor.dart'
    show InternalDioErrorProcessor;
export 'src/data/remote/connection_checker/always_have_connection.dart'
    show AlwaysHaveConnection;
export 'src/data/remote/connection_checker/mobile_connection_checker.dart'
    show MobileConnectionChecker;
export 'src/data/remote/base/retry_policy.dart' show RetryPolicy;

export 'src/data/remote/base/cache_interceptor.dart';
export 'src/data/remote/dio/params/api_client_params.dart' show ApiClientParams;
export 'src/domain/common/converter/mapper.dart';
export 'src/domain/entity/common/data_response.dart';
export 'src/domain/entity/common/operation_status.dart' show OperationStatus;
