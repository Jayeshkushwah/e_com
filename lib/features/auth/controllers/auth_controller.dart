import 'package:e_com/routes/app_pages.dart';
import 'package:e_com/services/local_storage_service.dart';
import 'package:go_router/go_router.dart';
import 'package:e_com/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

  final FirebaseAuthService _authService = Get.put(FirebaseAuthService());

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;

  late UserCredential user;

  void login(BuildContext context) async {
    try {
      isLoading.value = true;
      user = await _authService.login(
        emailController.text.trim(),
        passwordController.text.trim()
      );
      if(user.user != null){
        await LocalStorageService.saveLoginInfo(user.user!.email!);
        if (context.mounted) {
           context.go(Routes.home);
        }
      }
    } catch(e) {
      print("Login Failed $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Failed: $e")));
      }
    } finally {
      isLoading.value = false;
    }
  }

  void signUp(BuildContext context) async {
    try {
      isLoading.value = true;
      user = await _authService.signUp(
        emailController.text.trim(),
        passwordController.text.trim()
      );
      if(user.user != null){
        await LocalStorageService.saveLoginInfo(user.user!.email!);
        if (context.mounted) {
           context.go(Routes.home);
        }
      }
    } catch(e) {
      print("Signup Failed $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Signup Failed: $e")));
      }
    } finally {
      isLoading.value = false;
    }
  }

  void logout(BuildContext context) async {
    try {
      isLoading.value = true;
      await _authService.logout();
      await LocalStorageService.clearSession();
      if (context.mounted) {
        Get.deleteAll();
        context.go(Routes.login);
      }
    } catch(e) {
      print("Logout Failed $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Logout Failed: $e")));
      }
    } finally {
      isLoading.value = false;
    }
  }
}