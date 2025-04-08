import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:food_delivery/service/database.dart";
import "package:food_delivery/service/shared_pref.dart";
import 'package:http/http.dart' as http;
import "package:flutter/material.dart";
import "package:food_delivery/service/widget_support.dart";
import "package:random_string/random_string.dart";

class DetailPage extends StatefulWidget {
  String image, name, price;
  DetailPage({
    super.key,
    required this.image,
    required this.name,
    required this.price,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController addresscontroller = new TextEditingController();
  Map<String, dynamic>? paymentIntent;
  String? name, id, email, address;
  int quantity = 1, totalprice = 0;
  FirebaseAuth myAuth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    totalprice = int.parse(widget.price);
    super.initState();
    id = myAuth.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xffef2b39),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(Icons.arrow_back, size: 30, color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Image.network(
                widget.image,
                height: MediaQuery.of(context).size.height / 3,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20),
            Text(widget.name, style: AppWidget.HeadlineTextFeildStyle()),
            Text("\$${widget.price}", style: AppWidget.priceTextFeildStyle()),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                "Cheese pizza is a classic favorite, featuring a crispy crust topped with rich tomato sauce and gooey, melted cheese. Simple yet delicious, it’s loved for its perfect balance of flavors and textures,",
                style: AppWidget.SimpleTextFeildStyle(),
              ),
            ),
            SizedBox(height: 20),
            Text("Quantity", style: AppWidget.SimpleTextFeildStyle()),
            SizedBox(height: 10),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    quantity = quantity + 1;
                    totalprice = totalprice + int.parse(widget.price);
                    setState(() {});
                  },
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xffef2b39),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 20),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  quantity.toString(),
                  style: AppWidget.HeadlineTextFeildStyle(),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    if (quantity > 1) {
                      quantity = quantity - 1;
                      totalprice = totalprice - int.parse(widget.price);
                      setState(() {});
                    }
                  },
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xffef2b39),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.remove, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 60,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Color(0xffef2b39),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "\$$totalprice",
                        style: AppWidget.boldwhiteTextFeildStyle(),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 30),
                GestureDetector(
                  onTap: () {
                    db.collection("users").doc(myAuth.currentUser!.uid).update({
                      "carts": {
                        "name": widget.name,
                        "img": widget.image,
                        "Totalprice": totalprice,
                        "quantity": quantity,
                      },
                    });
                  },
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 70,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Add to cart",
                          style: AppWidget.whiteTextFeildStyle(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future openBox() => showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          content: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.cancel),
                      ),
                      SizedBox(width: 30),
                      Text(
                        "add the address",
                        style: TextStyle(
                          color: Color(0xff008080),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("Add Address"),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38, width: 20),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: addresscontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "address",
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      await SharedpreferenceHelper().saveUserAddress(
                        addresscontroller.text,
                      );
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Container(
                        width: 100,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color(0xFF008080),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Add",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
  );
}
