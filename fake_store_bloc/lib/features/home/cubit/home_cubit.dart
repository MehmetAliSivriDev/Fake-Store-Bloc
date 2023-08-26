import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fake_store_bloc/features/home/model/product_model.dart';
import 'package:fake_store_bloc/features/home/service/home_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeService) : super(const HomeState()) {
    initalComplete();
  }

  final IHomeService homeService;

  Future<void> initalComplete() async {
    await Future.microtask(() => {emit(const HomeState(isInitial: true))});
    await Future.wait([fecthAllItems(), fetchAllCategories()]);
  }

  Future<void> fecthAllItems() async {
    _changeLoading();
    final response = await homeService.fetchAllProducts(isLazy: true);
    emit(state.copyWith(items: response ?? []));
    _changeLoading();
  }

  Future<void> fetchAllCategories() async {
    final response = await homeService.fetchAllCategories();
    emit(state.copyWith(categories: response));
  }

  Future<void> fetchNewItems() async {
    if (state.isLoading ?? false) {
      return;
    }
    _changeLoading();
    int _pageNumber = (state.pageNumber ?? 0);
    final response =
        await homeService.fetchAllProducts(count: ++_pageNumber * 5);
    _changeLoading();
    emit(state.copyWith(items: response, pageNumber: _pageNumber));
  }

  void _changeLoading() {
    emit(state.copyWith(isLoading: !(state.isLoading ?? false)));
  }
}
