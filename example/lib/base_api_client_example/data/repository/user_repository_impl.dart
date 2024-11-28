import 'package:example/base_api_client_example/core/mapper/dio_server_error_mapper.dart';
import 'package:example/base_api_client_example/data/mapper/user_mapper.dart';
import 'package:example/base_api_client_example/data/source/user_source.dart';
import 'package:example/base_api_client_example/domain/entity/user_entity.dart';
import 'package:example/base_api_client_example/domain/repository/user_repository.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';

class UserRepositoryImpl implements UserRepository {
  final UserSource _userSource;
  final _userMapper = UserMapper();

  UserRepositoryImpl(this._userSource);

  @override
  Future<Result<List<UserEntity>>> getUsers() async {
    try {
      final userResponse = await _userSource.getUsers();
      if (userResponse.isSuccess()) {
        final models = userResponse.data.users ?? List.empty();
        final users = models
            .map(
              (model) => _userMapper.map(model),
            )
            .toList();

        return Result.ok(users);
      } else {
        final error = DioServerErrorMapper().mapToFailure(
          userResponse,
        );
        return Result.error(error: error);
      }
    } catch (e) {
      return Result.error(
        error: ApiFailure(ServerFailure.unknown),
      );
    }
  }
}
