import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/service/widget_support.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Map<String, dynamic>? cartData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCartData();
  }

  Future<void> fetchCartData() async {
    try {
      String uid = _auth.currentUser!.uid;
      DocumentSnapshot userDoc = await _db.collection("users").doc(uid).get();

      setState(() {
        cartData = userDoc.get("carts");
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching cart data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : cartData == null
              ? Center(child: Text("No orders yet!"))
              : Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Orders",
                            style: AppWidget.HeadlineTextFeildStyle(),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Color(0xFFececf8),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: Material(
                                  elevation: 3,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height/4,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.location_on_outlined,
                                                color: Color(0xffef2b39)),
                                            SizedBox(width: 10),
                                            Text("Near Market",
                                                style: AppWidget
                                                    .SimpleTextFeildStyle()),
                                          ],
                                        ),
                                        Divider(),

                                        // Cart Info
                                        Row(
                                          children: [
                                            if (cartData!['img'] != null)
                                              Image.network(
                                                cartData!['img'],
                                                height: 50,
                                                width: 50,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) =>
                                                    Icon(Icons.broken_image),
                                              )
                                            else
                                              Icon(Icons.fastfood,
                                                  size: 50,
                                                  color: Colors.grey),
                                            SizedBox(width: 20),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  cartData!['name'] ??
                                                      "No Name",
                                                  style: AppWidget
                                                      .boldTextFeildStyle(),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                        Icons
                                                            .format_list_numbered,
                                                        color:
                                                            Color(0xffef2b39)),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      "${cartData!['quantity'] ?? '0'}",
                                                      style: AppWidget
                                                          .boldTextFeildStyle(),
                                                    ),
                                                    SizedBox(width: 30),
                                                    Icon(
                                                        Icons
                                                            .monetization_on,
                                                        color:
                                                            Color(0xffef2b39)),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      "\$${cartData!['Totalprice'] ?? '0.00'}",
                                                      style: AppWidget
                                                          .boldTextFeildStyle(),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(height: 30,),
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(left: 20,right: 20),
                    width: MediaQuery.of(context).size.width/2,
                    decoration: BoxDecoration(color: Color(0xffef2b39),borderRadius: BorderRadius.circular(10)),
                    child: Center(child: Text("Order Now",style: AppWidget.boldwhiteTextFeildStyle(),)),
                  )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
    );
  }
}