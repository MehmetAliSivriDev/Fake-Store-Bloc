import 'package:fake_store_bloc/features/home/model/product_model.dart';
import 'package:vexana/vexana.dart';

class ProductNetworkManager extends NetworkManager<ProductModel> {
  ProductNetworkManager()
      : super(options: BaseOptions(baseUrl: 'https://fakestoreapi.com/'));
}
