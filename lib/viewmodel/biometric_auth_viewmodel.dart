import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';

import '../services/local_auth_service.dart';

class BiometricAuthViewModel extends ChangeNotifier {
  final LocalAuthService _authService;
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _errorMessage;
  List<BiometricType> _availableBiometrics = [];
  bool _biometricAvailable = false;

  BiometricAuthViewModel(this._authService);

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<BiometricType> get availableBiometrics => _availableBiometrics;
  bool get biometricAvailable => _biometricAvailable;

  Future<void> checkBiometricSupport() async {
    try {
      _biometricAvailable = await _authService.checkBiometrics();
      if (_biometricAvailable) {
        _availableBiometrics = await _authService.getAvailableBiometrics();
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error checking biometrics: $e';
      notifyListeners();
    }
  }

  Future<void> authenticate() async {
    _isLoading = true;
    notifyListeners();
    try {
      _isAuthenticated = await _authService.authenticate();
      _errorMessage = _isAuthenticated ? null : 'Authentication failed';
    } catch (e) {
      _errorMessage = 'Authentication error: $e';
      _isAuthenticated = false;
    }
    _isLoading = false;
    notifyListeners();
  }
}
