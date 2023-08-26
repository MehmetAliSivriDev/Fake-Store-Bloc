import 'package:flutter/material.dart';

class ProductPadding extends EdgeInsets {
  const ProductPadding.scaffoldPadding() : super.all(20);
  const ProductPadding.cardTextPadding() : super.all(10);
  const ProductPadding.ratingCardPadding()
      : super.only(top: 5, bottom: 5, left: 10, right: 10);
  const ProductPadding.ratingStarPadding() : super.only(right: 6);
}
