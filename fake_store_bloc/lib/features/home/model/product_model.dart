import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends INetworkModel<ProductModel> with EquatableMixin {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  ProductModel(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image,
      this.rating});

  @override
  Map<String, dynamic> toJson() {
    return _$ProductModelToJson(this);
  }

  @override
  ProductModel fromJson(Map<String, dynamic> json) {
    return _$ProductModelFromJson(json);
  }

  @override
  List<Object?> get props => [id];

  @override
  String toString() {
    return 'title: $title \n price: $price \n description: $description \n category: $category \n';
  }
}

@JsonSerializable()
class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return _$RatingFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RatingToJson(this);
  }
}
