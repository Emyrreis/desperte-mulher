import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/welcome.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // forca orientacao em retrato
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const DesperteMulherApp());
}

class DesperteMulherApp extends StatelessWidget {
  const DesperteMulherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desperte Mulher',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const WelcomeScreen(),
    );
  }
}
