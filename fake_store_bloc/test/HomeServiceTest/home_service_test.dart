import 'package:fake_store_bloc/features/home/service/home_service.dart';
import 'package:fake_store_bloc/product/network/product_network_manager.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late IHomeService homeService;

  setUp(() {
    homeService = HomeService(ProductNetworkManager());
  });
  test('Fetch Products Test "Lazy"', () async {
    final response = await homeService.fetchAllProducts(isLazy: true);

    expect(response, isNotNull);
  });

  test('Fetch Products Test "Not Lazy"', () async {
    final response = await homeService.fetchAllProducts(isLazy: false);

    expect(response, isNotNull);
  });

  test(
      'Fetch Categories Test - [electronics, jewelery, mens clothing, womens clothing]',
      () async {
    final response = await homeService.fetchAllCategories();

    expect(response, isNotNull);
  });
}
