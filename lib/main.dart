import 'package:flutter/material.dart';
import 'styles.dart';
import 'study_store.dart';
import 'screens/login_page.dart';
import 'screens/app_shell.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StudyStore.instance.load();
  runApp(const MeuSaberApp());
}

class MeuSaberApp extends StatelessWidget {
  const MeuSaberApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu Saber',
      theme: AppColor.theme.copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
      ),
      home: StudyStore.instance.signedIn ? const AppShell() : const LoginPage(),
    );
  }
}
