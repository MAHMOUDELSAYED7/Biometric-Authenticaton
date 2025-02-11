import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/local_auth_service.dart';
import 'view/biometric_screen.dart';
import 'viewmodel/biometric_auth_viewmodel.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (_) => BiometricAuthViewModel(LocalAuthService()),
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biometric Authentication',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          secondary: Colors.blueAccent,
          primary: Colors.blueAccent,
        ),
      ),
      home: const BiometricScreen(),
    );
  }
}
