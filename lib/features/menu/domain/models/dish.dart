class Dish {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String modelUrl;
  final int calories;
  final int spiceLevel; // 0-5
  final bool isVeg;
  final double rating;
  final bool isChefRecommendation;

  const Dish({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.modelUrl,
    required this.calories,
    required this.spiceLevel,
    required this.isVeg,
    required this.rating,
    this.isChefRecommendation = false,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
      modelUrl: json['modelUrl'],
      calories: json['calories'],
      spiceLevel: json['spiceLevel'],
      isVeg: json['isVeg'],
      rating: json['rating'].toDouble(),
      isChefRecommendation: json['isChefRecommendation'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'modelUrl': modelUrl,
      'calories': calories,
      'spiceLevel': spiceLevel,
      'isVeg': isVeg,
      'rating': rating,
      'isChefRecommendation': isChefRecommendation,
    };
  }
}
