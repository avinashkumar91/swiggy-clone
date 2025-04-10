import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String Id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(Id)
        .set(userInfoMap);
  }

  Future addUserOrderDetails(Map<String, dynamic> userOrderMap, String id,String orderid) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id).collection("Orders").doc(orderid)
        .set(userOrderMap);
  }

  Future addAdminOrderDetails(Map<String, dynamic> userOrderMap,String orderid) async {
    return await FirebaseFirestore.instance
        .collection("Orders").doc(orderid)
        .set(userOrderMap);
  }
}
