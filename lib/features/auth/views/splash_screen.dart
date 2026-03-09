import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:e_com/routes/app_pages.dart';
import 'package:e_com/services/local_storage_service.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    // Simulate initialization delay
    await Future.delayed(const Duration(seconds: 2));

    bool isLoggedIn = await LocalStorageService.isLoggedIn();

    if (mounted) {
      if (isLoggedIn) {
        context.go(Routes.home);
      } else {
        context.go(Routes.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Welcome to E Comm...',
              style: TextStyle(
                fontSize: 20
              ),
            ),
          ],
        ),
      ),
    );
  }
}
