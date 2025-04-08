class PizzaModel {
  String? name;
  String? price;
  String? image;

  PizzaModel({this.name, this.price, this.image});

  factory PizzaModel.fromMap(Map<String, dynamic> map) {
    return PizzaModel(
      name: map['name'] ?? '',
      price: map['price'] ?? '',
      image: map['img'] ?? '',
    );
  }
}
