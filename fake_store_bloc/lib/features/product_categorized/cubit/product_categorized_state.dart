part of 'product_categorized_cubit.dart';

class ProductCategorizedState extends Equatable {
  const ProductCategorizedState({this.itemsCategorized, this.isLoading});

  final List<ProductModel>? itemsCategorized;
  final bool? isLoading;
  @override
  List<Object?> get props => [itemsCategorized, isLoading];

  ProductCategorizedState copyWith({
    List<ProductModel>? itemsCategorized,
    bool? isLoading,
  }) {
    return ProductCategorizedState(
      itemsCategorized: itemsCategorized ?? this.itemsCategorized,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
