import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  final _auth = LocalAuthentication();

  Future<bool> checkBiometrics() async {
    return await _auth.canCheckBiometrics;
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    return await _auth.getAvailableBiometrics();
  }

  Future<bool> authenticate() async {
    return await _auth.authenticate(
      localizedReason: 'Authenticate to access',
      options: const AuthenticationOptions(
        // biometricOnly: true,
        stickyAuth: true,
      ),
    );
  }
}
