import 'package:fake_store_bloc/features/home/model/product_model.dart';
import 'package:fake_store_bloc/product/borderRadius/product_border_radius.dart';
import 'package:fake_store_bloc/product/padding/product_padding.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required ProductModel? model,
  })  : _model = model,
        super(key: key);

  final ProductModel? _model;

  final String _productText = "Product";
  final String _categoryText = "Category";
  final String _decriptionText = "Description";

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;

    return Card(
        elevation: 10,
        child: Column(
          children: [
            SizedBox(
                width: _width,
                height: _height * 0.4,
                child: Stack(fit: StackFit.expand, children: [
                  ClipRRect(
                    borderRadius: const ProductBorderRadius.cardImageBR(),
                    child: Image.network(
                      _model?.image ?? "",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Positioned(
                      top: 10,
                      right: 10,
                      child: Card(
                        color: Colors.purple[100],
                        child: Padding(
                          padding: const ProductPadding.ratingCardPadding(),
                          child: Row(
                            children: [
                              const Padding(
                                padding: ProductPadding.ratingStarPadding(),
                                child: Icon(
                                  Icons.star_rounded,
                                ),
                              ),
                              Text(
                                _model?.rating?.rate.toString() ?? "",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      )),
                  Positioned(
                      bottom: 10,
                      right: 10,
                      child: Card(
                        color: Colors.purple[100],
                        child: Padding(
                          padding: const ProductPadding.ratingCardPadding(),
                          child: Row(
                            children: [
                              const Padding(
                                padding: ProductPadding.ratingStarPadding(),
                                child: Icon(
                                  Icons.attach_money_outlined,
                                ),
                              ),
                              Text(
                                _model?.price?.toString() ?? "",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ))
                ])),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const ProductPadding.cardTextPadding(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _productText,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    _model?.title ?? "",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Divider(thickness: 3, height: 10),
                  Text(
                    _categoryText,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    _model?.category ?? "",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Divider(thickness: 3, height: 10),
                  Text(
                    _decriptionText,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    _model?.description ?? "",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
