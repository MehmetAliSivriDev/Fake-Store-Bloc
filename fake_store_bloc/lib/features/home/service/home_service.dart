import 'package:fake_store_bloc/features/home/model/product_model.dart';
import 'package:fake_store_bloc/product/model/query/product_queries.dart';
import 'package:vexana/vexana.dart';

enum _HomeServicePath { products, categories }

abstract class IHomeService {
  late final INetworkManager _networkManager;

  IHomeService(INetworkManager networkManager)
      : _networkManager = networkManager;

  Future<List<ProductModel>?> fetchAllProducts(
      {int count = 5, bool isLazy = true});
  Future<List<String>?> fetchAllCategories();
}

class HomeService extends IHomeService {
  HomeService(INetworkManager networkManager) : super(networkManager);

  @override
  Future<List<String>?> fetchAllCategories() async {
    final response = await _networkManager.sendPrimitive(
        '${_HomeServicePath.products.name}/${_HomeServicePath.categories.name}');

    return response is List ? response.map((e) => '$e').toList() : null;
  }

  @override
  Future<List<ProductModel>?> fetchAllProducts(
      {int count = 5, bool isLazy = true}) async {
    final IResponseModel<List<ProductModel>?, INetworkModel?> response;

    if (isLazy) {
      response = await _networkManager.send<ProductModel, List<ProductModel>>(
          _HomeServicePath.products.name,
          parseModel: ProductModel(),
          method: RequestType.GET,
          queryParameters:
              Map.fromEntries([ProductQueries.limit.toMapEntry('$count')]));
    } else {
      response = await _networkManager.send<ProductModel, List<ProductModel>>(
        _HomeServicePath.products.name,
        parseModel: ProductModel(),
        method: RequestType.GET,
      );
    }

    return response.data;
  }
}
