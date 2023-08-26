import 'package:fake_store_bloc/features/home/service/home_service.dart';
import 'package:fake_store_bloc/features/product_categorized/cubit/product_categorized_cubit.dart';
import 'package:fake_store_bloc/product/network/product_network_manager.dart';
import 'package:fake_store_bloc/product/padding/product_padding.dart';
import 'package:fake_store_bloc/product/widget/circular_loading.dart';
import 'package:fake_store_bloc/product/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCategorized extends StatelessWidget {
  const ProductCategorized({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductCategorizedCubit(HomeService(ProductNetworkManager()))
            ..fecthCategorizedItems(category),
      child: Scaffold(
        appBar: AppBar(
          title: Text(category),
        ),
        body: Padding(
          padding: const ProductPadding.scaffoldPadding(),
          child: BlocBuilder<ProductCategorizedCubit, ProductCategorizedState>(
            builder: (context, state) {
              return state.isLoading == true
                  ? const CircularLoading()
                  : _buildCategorizedItems(state);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCategorizedItems(ProductCategorizedState state) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 20,
        );
      },
      itemCount: state.itemsCategorized?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return ProductCard(model: state.itemsCategorized?[index]);
      },
    );
  }
}
