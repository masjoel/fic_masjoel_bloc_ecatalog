import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fic_masjoel_ecatalog/data/models/response/product_response_model.dart';
import 'package:http/http.dart' as http;

class ProductDataSource {
  Future<Either<String, List<ProductResponseModel>>> getAllProduct() async {
    final response =
        await http.get(Uri.parse('https://api.escuelajs.co/api/v1/products/'));
    if (response.statusCode == 200) {
      return Right(List<ProductResponseModel>.from(jsonDecode(response.body)
          .map((x) => ProductResponseModel.fromMap(x))));
    } else {
      return const Left('get product error');
    }
  }
}
