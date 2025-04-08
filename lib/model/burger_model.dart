class BurgerModel {
  String? name;
  String? price;
  String? image;

  BurgerModel({this.name, this.price, this.image});

  factory BurgerModel.fromMap(Map<String, dynamic> map) {
    return BurgerModel(
      name: map['name'] ?? '',
      price: map['price'] ?? '',
      image: map['img'] ?? '',
    );
  }
}
