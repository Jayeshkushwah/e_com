import 'package:e_com/features/auth/controllers/auth_controller.dart';
import 'package:e_com/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Spacer(),
            const Text(
              "Create Account",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: controller.emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: controller.passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Obx(() => ElevatedButton(
                onPressed: controller.isLoading.value ? null : () {
                  controller.signUp(context);
                },
                child: controller.isLoading.value 
                    ? const CircularProgressIndicator()
                    : const Text("Sign Up"),
              )),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                context.go(Routes.login);
              },
              child: const Text("Already have an account? Login"),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
