import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

import '../viewmodel/biometric_auth_viewmodel.dart';

class BiometricScreen extends StatelessWidget {
  const BiometricScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometric Auth'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Consumer<BiometricAuthViewModel>(
        builder: (context, viewModel, _) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (viewModel.isLoading)
                    const CircularProgressIndicator(color: Colors.blueAccent)
                  else ...[
                    ElevatedButton(
                      onPressed: viewModel.checkBiometricSupport,
                      child: const Text('Check Biometric Support'),
                    ),
                    const SizedBox(height: 20),
                    if (viewModel.biometricAvailable) ...[
                      Text(
                        'Available Biometrics: ${viewModel.availableBiometrics.map((b) => _biometricName(b)).join(', ')}',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: viewModel.authenticate,
                        child: const Text('Authenticate'),
                      ),
                    ],
                    if (viewModel.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          viewModel.errorMessage!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    if (viewModel.isAuthenticated)
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text('Authentication Successful!',
                            style: TextStyle(color: Colors.green)),
                      ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _biometricName(BiometricType type) {
    switch (type) {
      case BiometricType.face:
        return 'Face ID';
      case BiometricType.fingerprint:
        return 'Fingerprint';
      case BiometricType.iris:
        return 'Iris';
      case BiometricType.weak:
        return 'Weak Biometric';
      case BiometricType.strong:
        return 'Strong Biometric';
    }
  }
}
