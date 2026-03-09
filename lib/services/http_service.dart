import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:e_com/data/models/product_model.dart';
import 'package:get/get.dart';

class HttpService extends GetxService {
  final String _baseUrl = "https://fakestoreapi.com";

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products'));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}
