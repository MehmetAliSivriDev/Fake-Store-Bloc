import 'package:fake_store_bloc/features/product_categorized/view/product_categorized.dart';
import 'package:fake_store_bloc/product/padding/product_padding.dart';
import 'package:fake_store_bloc/product/widget/circular_loading.dart';
import 'package:fake_store_bloc/product/widget/divider_close_button.dart';
import 'package:fake_store_bloc/product/widget/product_card.dart';
import 'package:fake_store_bloc/product/widget/show_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fake_store_bloc/features/home/cubit/home_cubit.dart';
import 'package:fake_store_bloc/features/home/service/home_service.dart';
import 'package:fake_store_bloc/product/network/product_network_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with ShowBottomSheet {
  final String _appBarText = "Fake Store App";
  final String _filterButtonText = "Filters";

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _listenScroll(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        context.read<HomeCubit>().fetchNewItems();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(HomeService(ProductNetworkManager())),
      child: Scaffold(
          appBar: AppBar(
            title: Text(_appBarText),
            actions: [
              _filterButton(context),
            ],
          ),
          body: Padding(
            padding: const ProductPadding.scaffoldPadding(),
            child: _buildListView(),
          )),
    );
  }

  Widget _filterButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          showCustomSheet(context, _buildFilterBottomSheet());
        },
        icon: Row(
          children: [
            const Icon(Icons.filter_list),
            Text(
              _filterButtonText,
              style: Theme.of(context).textTheme.titleSmall,
            )
          ],
        ));
  }

  Widget _buildFilterBottomSheet() {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: HomeCubit(HomeService(ProductNetworkManager())),
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            children: [
              const DividerCloseButton(),
              _buildCategories(state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategories(HomeState state) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: state.categories?.length ?? 0,
      itemBuilder: (context, index) {
        return Padding(
          padding: const ProductPadding.cardTextPadding(),
          child: Card(
            elevation: 8,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => ProductCategorized(
                      category: state.categories?[index].toString() ?? ""),
                ));
              },
              title: Text(
                state.categories?[index].toString() ?? "",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
            ),
          ),
        );
      },
    );
  }

  Widget _buildListView() {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.isInitial) {
          _listenScroll(context);
        }
      },
      builder: (context, state) {
        return ListView.separated(
          controller: _scrollController,
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 20,
            );
          },
          itemCount: state.items?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ProductCard(model: state.items?[index]),
                state.items != null &&
                        state.items!.isNotEmpty &&
                        index == state.items!.length - 1
                    ? const CircularLoading()
                    : const SizedBox.shrink(),
              ],
            );
          },
        );
      },
    );
  }
}
