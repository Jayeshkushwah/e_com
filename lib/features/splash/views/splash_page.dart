import 'package:e_com/routes/app_pages.dart';
import 'package:e_com/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    // Simulate initialization delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Check authentication status
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
            FlutterLogo(size: 100),
            SizedBox(height: 20),
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text('Welcome to E Comm...'),
          ],
        ),
      ),
    );
  }
}
