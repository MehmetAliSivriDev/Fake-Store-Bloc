// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.items,
    this.isLoading,
    this.categories,
    this.pageNumber,
    this.isInitial = false,
  });

  final List<ProductModel>? items;
  final bool? isLoading;
  final List<String>? categories;
  final int? pageNumber;
  final bool isInitial;

  @override
  List<Object?> get props => [items, isLoading, categories, pageNumber];

  HomeState copyWith({
    List<ProductModel>? items,
    bool? isLoading,
    List<String>? categories,
    int? pageNumber,
  }) {
    return HomeState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
      pageNumber: pageNumber ?? this.pageNumber,
    );
  }
}
