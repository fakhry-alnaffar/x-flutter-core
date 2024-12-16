import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:onix_flutter_core/onix_flutter_core.dart';
import 'package:onix_flutter_core/src/data/remote/extension/connectivity_ext.dart';

class MobileConnectionChecker implements ConnectionChecker {
  final InternetConnection _connection;

  final Connectivity _connectivity;

  MobileConnectionChecker({
    InternetConnection? internetConnection,
    Connectivity? connectivity,
  })  : _connection = internetConnection ?? InternetConnection(),
        _connectivity = connectivity ?? Connectivity();

  @override
  Future<bool> hasConnection() async {
    final hasAccess = await _connection.hasInternetAccess;
    final connectivityResult = await _connectivity.checkConnectivity();
    return hasAccess && connectivityResult.hasConnection;
  }
}
