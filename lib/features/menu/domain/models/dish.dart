// lib/features/menu/domain/models/dish.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'dish.freezed.dart';
part 'dish.g.dart';

@freezed
class Dish with _$Dish {
  const factory Dish({
    required String id,
    required String name,
    required String description,
    required double price,
    required String imageUrl,
    required String modelUrl,
    required int calories,
    required int spiceLevel, // 0-5
    required bool isVeg,
    required double rating,
    @Default(false) bool isChefRecommendation,
  }) = _Dish;

  factory Dish.fromJson(Map<String, dynamic> json) => _$DishFromJson(json);
}
