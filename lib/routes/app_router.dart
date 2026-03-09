import 'package:e_com/features/auth/views/login_page.dart';
import 'package:e_com/features/auth/views/signup_page.dart';
import 'package:e_com/features/auth/views/splash_screen.dart';
import 'package:e_com/features/home/views/home_page.dart';
import 'package:e_com/routes/app_pages.dart';
import 'package:go_router/go_router.dart';

abstract class AppPages {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.splash,
    routes: [
      GoRoute(
        path: Routes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.home,
        name: 'home',
        builder: (context, state) => const HomePage(title: 'Home'),
      ),
      GoRoute(
        path: Routes.login,
        name: 'login',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: Routes.signup,
        name: 'signup',
        builder: (context, state) => SignupPage(),
      ),
    ],
  );
}
