import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityProvider extends ChangeNotifier {
  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();

  ConnectivityProvider() {
    _initConnectivity();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  ConnectivityResult get connectivityResult => _connectivityResult;

  Future<void> _initConnectivity() async {
    try {
      var result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      print("Error checking connectivity: $e");
    }
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    if (_connectivityResult != result) {
      _connectivityResult = result;
      notifyListeners();
    }
  }
}
