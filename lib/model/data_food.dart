class Food {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;

  Food(this.idMeal, this.strMeal, this.strMealThumb);
  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(json['idMeal'], json['strMeal'], json['strMealThumb']);
  }
}

class FoodDetail {
  final String strInstructionsDetail;

  FoodDetail(this.strInstructionsDetail);
  factory FoodDetail.fromJson(Map<String, dynamic> json) {
    return FoodDetail(json['strInstructions']);
  }
}

