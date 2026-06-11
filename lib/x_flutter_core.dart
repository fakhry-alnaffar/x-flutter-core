/// x_flutter_core — networking, storage, and infrastructure for Flutter.
///
/// This is the primary public entry point for the x_flutter ecosystem.
/// Importing this library gives you everything you need:
///
/// **From x_flutter_core_models (re-exported):**
/// - [Failure], [ApiFailure] and all subtypes — typed domain failures
/// - [CanceledRequestFailure], [ServerFailure] — network failure taxonomy
/// - [BaseProgressState], [DefaultProgressState] — loading state contracts
///
/// **From x_flutter_core (networking + infrastructure):**
/// - [DataResponse] — sealed transport result with 7 variants
/// - [RequestProcessor], [ErrorProcessor] — request pipeline contracts
/// - [ApiClient], [DioClientModule] — Dio HTTP client
/// - [ServerErrorMapper] — DataResponse → Failure converter
/// - [KeyValueStorage], [SharedPreferencesStorage], [SecuredPreferencesStorage]
/// - [ConnectionChecker], [HttpStatus], [RetryPolicy]
/// - [Mapper], [MapperIterable] — domain converter contracts
/// - [OperationStatus] — simple success/failed outcome enum
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

// Re-export all x_flutter_core_models types so consumers need only one import.
export 'package:x_flutter_core_models/x_flutter_core_models.dart';

// Local storage
export 'src/data/local/prefs/shared_preferences_storage.dart';
export 'src/data/local/prefs/secured_preferences_storage.dart';
export 'src/data/local/base/key_value_storage.dart';
export 'src/data/local/base/key_value_reloadable_storage.dart';

// HTTP client
export 'src/data/remote/base/base_api_client.dart' show BaseApiClient;
export 'src/data/remote/base/http_status.dart' show HttpStatus;
export 'src/data/remote/base/server_error_mapper.dart' show ServerErrorMapper;
export 'src/data/remote/base/connection_checker.dart';
export 'src/data/remote/dio/api_client.dart' show ApiClient;
export 'src/data/remote/dio/dio_client_module.dart' show DioClientModule;

// Request pipeline
export 'src/data/remote/base/processor/request_processor.dart'
    show RequestProcessor, OnRequest, OnParse;
export 'src/data/remote/dio/internal_dio_request_processor.dart'
    show InternalDioRequestProcessor;
export 'src/data/remote/base/processor/error_processor.dart'
    show ErrorProcessor, OnCustomError;
export 'src/data/remote/dio/internal_dio_error_processor.dart'
    show InternalDioErrorProcessor;

// Connectivity
export 'src/data/remote/connection_checker/always_have_connection.dart'
    show AlwaysHaveConnection;
export 'src/data/remote/connection_checker/mobile_connection_checker.dart'
    show MobileConnectionChecker;
export 'src/data/remote/base/retry_policy.dart' show RetryPolicy;

// Caching
export 'src/data/remote/base/cache_interceptor.dart';
export 'src/data/remote/dio/params/api_client_params.dart' show ApiClientParams;

// DataResponse — canonical transport result type
// Mapper, OperationStatus are provided via the x_flutter_core_models re-export above.
export 'src/domain/entity/common/data_response.dart';

// Result — application/domain layer result type (distinct from DataResponse)
export 'src/domain/entity/common/result.dart';

// DTO utilities
export 'src/data/remote/base/base_empty_response.dart' show BaseEmptyResponse;
