import 'package:example/base_api_client_example/data/log_interceptor.dart';
import 'package:example/base_api_client_example/util/custom_error_parser.dart';
import 'package:get_it/get_it.dart';
import 'package:onix_flutter_core/onix_flutter_core.dart';

import 'base_api_client_example/data/repository/user_repository_impl.dart';
import 'base_api_client_example/data/source/user_source.dart';
import 'base_api_client_example/data/source/user_source_impl.dart';
import 'base_api_client_example/domain/repository/user_repository.dart';

void initializeDi(GetIt getIt) {
  // Registering the API client class
  final dioClientModule = _DioClientModule();

  getIt.registerLazySingleton<ApiClient>(
    () => dioClientModule.makeApiClient(
      ApiClientParams(
        baseUrl: 'https://jsonplaceholder.typicode.com/',
        defaultConnectTimeout: 5000,
        defaultReceiveTimeout: 5000,
        interceptors: [LogInterceptor()],
        headers: {}
      ),
    ),
    instanceName: 'apiInstanceName',
  );

  // Registering DioRequestProcessor
  getIt.registerLazySingleton<RequestProcessor>(
    () => dioClientModule.createInternalDioRequestProcessor(
      customErrorParser: CustomErrorParser.parse,
    ),
  );

  //getIt.registerLazySingleton(Request)

  // Registering UserSource
  getIt.registerLazySingleton<UserSource>(
    () => UserSourceImpl(
      getIt<ApiClient>(instanceName: 'apiInstanceName'),
      getIt<RequestProcessor>(),
    ),
  );

  // Registering UserRepository
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      getIt<UserSource>(),
    ),
  );
}

class _DioClientModule extends DioClientModule {}
