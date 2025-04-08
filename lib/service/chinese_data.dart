import 'package:food_delivery/model/chinese_model.dart';

List<ChineseModel> getChinese() {
  List<ChineseModel> chinese = [];
  ChineseModel chineseModel = ChineseModel();

  chineseModel.name = "Chinese 1";
  chineseModel.image = "images/chinese.png";
  chineseModel.price = "50";
  chinese.add(chineseModel);
  chineseModel = ChineseModel();

  chineseModel.name = "Chinese 2";
  chineseModel.image = "images/chinese.png";
  chineseModel.price = "50";
  chinese.add(chineseModel);
  chineseModel = ChineseModel();

  chineseModel.name = "Chinese 3";
  chineseModel.image = "images/chinese.png";
  chineseModel.price = "50";
  chinese.add(chineseModel);
  chineseModel = ChineseModel();

  chineseModel.name = "Chinese 4";
  chineseModel.image = "images/chinese.png";
  chineseModel.price = "50";
  chinese.add(chineseModel);
  chineseModel = ChineseModel();

  return chinese;
}