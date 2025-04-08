import 'package:food_delivery/model/mexican_model.dart';

List<MexicanModel> getMexican() {
  List<MexicanModel> mexican = [];
  MexicanModel mexicanModel = MexicanModel();

  mexicanModel.name = "Mexican 1";
  mexicanModel.image = "images/tacos.png";
  mexicanModel.price = "50";
  mexican.add(mexicanModel);
  mexicanModel = MexicanModel();

  mexicanModel.name = "Mexican 2";
  mexicanModel.image = "images/tacos.png";
  mexicanModel.price = "50";
  mexican.add(mexicanModel);
  mexicanModel = MexicanModel();

  mexicanModel.name = "Mexican 3";
  mexicanModel.image = "images/tacos.png";
  mexicanModel.price = "50";
  mexican.add(mexicanModel);
  mexicanModel = MexicanModel();

  mexicanModel.name = "Mexican 4";
  mexicanModel.image = "images/tacos.png";
  mexicanModel.price = "50";
  mexican.add(mexicanModel);
  mexicanModel = MexicanModel();

  return mexican;
}