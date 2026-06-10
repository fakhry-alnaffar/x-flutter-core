import 'package:example/base_api_client_example/data/log_interceptor.dart';
import 'package:example/base_api_client_example/data/repository/user_repository_impl.dart';
import 'package:example/base_api_client_example/data/source/user_source.dart';
import 'package:example/base_api_client_example/data/source/user_source_impl.dart';
import 'package:example/base_api_client_example/domain/repository/user_repository.dart';
import 'package:example/base_api_client_example/presentation/cubit/user_cubit.dart';
import 'package:example/base_api_client_example/util/custom_error_parser.dart';
import 'package:get_it/get_it.dart';
import 'package:x_flutter_core/x_flutter_core.dart';

void initializeDi(GetIt getIt) {
  final dioClientModule = _DioClientModule();

  getIt.registerLazySingleton<ApiClient>(
    () => dioClientModule.makeApiClient(
      ApiClientParams(
        baseUrl: 'https://jsonplaceholder.typicode.com/',
        defaultConnectTimeout: 5000,
        defaultReceiveTimeout: 5000,
        interceptors: [LogInterceptor()],
        headers: {},
      ),
    ),
    instanceName: 'apiInstanceName',
  );

  getIt.registerLazySingleton<RequestProcessor>(
    () => dioClientModule.createInternalDioRequestProcessor(
      customErrorParser: CustomErrorParser.parse,
    ),
  );

  getIt.registerLazySingleton<UserSource>(
    () => UserSourceImpl(
      getIt<ApiClient>(instanceName: 'apiInstanceName'),
      getIt<RequestProcessor>(),
    ),
  );

  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(getIt<UserSource>()),
  );

  // registerFactory so every BlocProvider gets a fresh Cubit instance.
  getIt.registerFactory<UserCubit>(
    () => UserCubit(getIt<UserRepository>()),
  );
}

class _DioClientModule extends DioClientModule {}
