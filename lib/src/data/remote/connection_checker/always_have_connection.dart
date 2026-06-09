import 'package:onix_flutter_core/onix_flutter_core.dart';

class AlwaysHaveConnection implements ConnectionChecker {
  const AlwaysHaveConnection();

  @override
  Future<bool> hasConnection() => Future.value(true);
}
