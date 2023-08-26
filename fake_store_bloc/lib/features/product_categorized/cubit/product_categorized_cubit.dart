import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fake_store_bloc/features/home/model/product_model.dart';
import 'package:fake_store_bloc/features/home/service/home_service.dart';

part 'product_categorized_state.dart';

class ProductCategorizedCubit extends Cubit<ProductCategorizedState> {
  ProductCategorizedCubit(this.homeService)
      : super(const ProductCategorizedState());
  final HomeService homeService;

  Future<void> fecthCategorizedItems(String category) async {
    _changeLoading();
    final response = await homeService.fetchAllProducts(isLazy: false);
    emit(state.copyWith(
        itemsCategorized: response
                ?.where((element) => element.category == category)
                .toList() ??
            []));
    _changeLoading();
  }

  void _changeLoading() {
    emit(state.copyWith(isLoading: !(state.isLoading ?? false)));
  }
}
