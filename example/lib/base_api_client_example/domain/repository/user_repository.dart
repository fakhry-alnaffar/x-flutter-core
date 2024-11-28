import 'package:example/base_api_client_example/domain/entity/user_entity.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';

abstract interface class UserRepository {
  Future<Result<List<UserEntity>>> getUsers();
}
