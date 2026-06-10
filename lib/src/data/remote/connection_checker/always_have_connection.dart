import 'package:x_flutter_core/x_flutter_core.dart';

class AlwaysHaveConnection implements ConnectionChecker {
  const AlwaysHaveConnection();

  @override
  Future<bool> hasConnection() => Future.value(true);
}
