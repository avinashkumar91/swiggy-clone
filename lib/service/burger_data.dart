import 'package:food_delivery/model/burger_model.dart';

List<BurgerModel> getBurger() {
  List<BurgerModel> burger = [];
  BurgerModel burgerModel = BurgerModel();

  burgerModel.name = "Cheese Burger";
  burgerModel.image = "images/burger1.png";
  burgerModel.price = "50";
  burger.add(burgerModel);
  burgerModel = BurgerModel();

  burgerModel.name = "veggie Burger1";
  burgerModel.image = "images/burger2.png";
  burgerModel.price = "60";
  burger.add(burgerModel);
  burgerModel = BurgerModel();

  burgerModel.name = "veggie Burger1";
  burgerModel.image = "images/burger2.png";
  burgerModel.price = "60";
  burger.add(burgerModel);
  burgerModel = BurgerModel();

  burgerModel.name = "veggie Burger1";
  burgerModel.image = "images/burger2.png";
  burgerModel.price = "60";
  burger.add(burgerModel);
  burgerModel = BurgerModel();

  return burger;
}