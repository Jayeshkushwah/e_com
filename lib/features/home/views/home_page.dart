import 'package:e_com/features/auth/controllers/auth_controller.dart';
import 'package:e_com/features/home/controllers/home_controller.dart';
import 'package:e_com/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // Initialize Controllers
    final HomeController homeController = Get.put(HomeController());
    
    // AuthController is already initialized in login/signup, so we just find it.
    // However, if the user directly lands here via cached route, we might need Get.put or conditionally check
    // Since AuthController handles logout we should get it. If it fails, fallback to Get.put
    final AuthController authController = Get.isRegistered<AuthController>() 
          ? Get.find<AuthController>() 
          : Get.put(AuthController());

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            FutureBuilder<String?>(
              future: LocalStorageService.getUserEmail(),
              builder: (context, snapshot) {
                return UserAccountsDrawerHeader(
                  accountName: const Text('User'),
                  accountEmail: Text(snapshot.data ?? 'Loading...'),
                  currentAccountPicture: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                authController.logout(context);
              },
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (homeController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (homeController.errorMessage.isNotEmpty) {
          return Center(child: Text('Error: ${homeController.errorMessage.value}'));
        }

        if (homeController.productList.isEmpty) {
          return const Center(child: Text('No products available.'));
        }

        return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: homeController.productList.length,
          itemBuilder: (context, index) {
            final product = homeController.productList[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                leading: product.image != null
                    ? Image.network(
                        product.image!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.image, size: 50),
                title: Text(
                  product.title ?? 'No Title',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text('\$${product.price?.toStringAsFixed(2) ?? '0.00'}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 16),
                    Text('${product.rating?.rate ?? 0.0}'),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
