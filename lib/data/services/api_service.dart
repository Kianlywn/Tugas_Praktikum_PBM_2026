import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/auth_response_model.dart';
import '../models/product_model.dart';
import '../../core/constants/api_constants.dart';
import 'storage_service.dart';

class ApiService {
  static Future<AuthResponseModel> login(String nim) async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.login}');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'username': nim, 'password': nim}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['success'] == true) {
      return AuthResponseModel.fromJson(data);
    } else {
      throw Exception(data['message'] ?? 'Login gagal');
    }
  }

  static Future<List<ProductModel>> getProducts() async {
    final token = await StorageService.getToken();
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.products}');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['success'] == true) {
      final List<dynamic> productsJson = data['data']['products'];
      return productsJson.map((p) => ProductModel.fromJson(p)).toList();
    } else {
      throw Exception(data['message'] ?? 'Gagal mengambil produk');
    }
  }

  static Future<ProductModel> addProduct({
    required String name,
    required int price,
    required String description,
  }) async {
    final token = await StorageService.getToken();
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.products}');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'price': price,
        'description': description,
      }),
    );

    final data = jsonDecode(response.body);

    if ((response.statusCode == 200 || response.statusCode == 201) &&
        data['success'] == true) {
      return ProductModel.fromJson(data['data']['product']);
    } else {
      throw Exception(data['message'] ?? 'Gagal menambah produk');
    }
  }

  static Future<Map<String, dynamic>> submitTask({
    required String name,
    required int price,
    required String description,
    required String githubUrl,
  }) async {
    final token = await StorageService.getToken();
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.submitTask}');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'price': price,
        'description': description,
        'github_url': githubUrl,
      }),
    );

    final data = jsonDecode(response.body);

    if ((response.statusCode == 200 || response.statusCode == 201) &&
        data['success'] == true) {
      return data;
    } else {
      throw Exception(data['message'] ?? 'Gagal submit tugas');
    }
  }
}