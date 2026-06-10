import 'package:example/base_api_client_example/data/model/user_model.dart';
import 'package:x_flutter_core/x_flutter_core.dart';

abstract interface class UserSource {
  Future<DataResponse<UserModelList>> getUsers();
}
