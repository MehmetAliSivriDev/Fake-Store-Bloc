import 'package:flutter/material.dart';

class ProductBorderRadius extends BorderRadius {
  const ProductBorderRadius.cardImageBR()
      : super.only(
            topRight: const Radius.circular(20),
            topLeft: const Radius.circular(20));
}
