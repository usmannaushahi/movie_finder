import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl extends NetworkInfo {
  NetworkInfoImpl();
  @override
  Future<bool> get isConnected => checkConnection();

  Future<bool> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else if ((connectivityResult == ConnectivityResult.mobile) ||
        (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.ethernet)) {
      return true;
    } else {
      return false;
    }
  }
}
