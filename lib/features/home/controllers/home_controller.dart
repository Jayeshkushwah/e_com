import 'package:e_com/data/models/product_model.dart';
import 'package:e_com/services/http_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final HttpService _httpService = Get.put(HttpService());

  var isLoading = true.obs;
  var productList = <ProductModel>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      errorMessage('');
      var products = await _httpService.getProducts();
      if (products.isNotEmpty) {
        productList.assignAll(products);
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
