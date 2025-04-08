import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/detail_page.dart';
import 'package:food_delivery/service/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  List<Map<String, dynamic>> pizza = [];
  List<Map<String, dynamic>> burger = [];
  List<Map<String, dynamic>> noodles = [];
  List<Map<String, dynamic>> chinese = [];
  List<Map<String, dynamic>> mexican = [];

  String track = "0"; // 0 = pizza, 1 = burger, 2 = chinese, 3 = mexican

  @override
  void initState() {
    super.initState();
    fetchCategoryData("Pizza").then((data) => setState(() => pizza = data));
    fetchCategoryData("Burger").then((data) => setState(() => burger = data));
    fetchCategoryData("Noodles").then((data) => setState(() => noodles = data));
    // fetchCategoryData("Chinese").then((data) => setState(() => chinese = data));
    // fetchCategoryData("Mexican").then((data) => setState(() => mexican = data));
  }

  Future<List<Map<String, dynamic>>> fetchCategoryData(String category) async {
    final snapshot =
        await db
            .collection("products")
            .doc(category)
            .collection(category)
            .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> currentList =
        track == "0"
            ? pizza
            : track == "1"
            ? burger
            : noodles;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 20, top: 40),
        child: Column(
          children: [
            // Top header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("images/logo1.png", height: 50, width: 100),
                    Text(
                      " Order your Favorite Food!",
                      style: AppWidget.SimpleTextFeildStyle(),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "images/boy.jpg",
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            // Search bar
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFFececf8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search...",
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => getUserDetails(),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xffef2b39),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.search, color: Colors.white, size: 30),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Category Row
            SizedBox(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  categoryTile("Pizza", "images/pizza.png", "0"),
                  categoryTile("Burger", "images/burger.png", "1"),
                  categoryTile("Noodles", "images/chinese.png", "2"),
                ],
              ),
            ),

            SizedBox(height: 10),

            // Food Grid
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.only(right: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.57,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 10,
                ),
                itemCount: currentList.length,
                itemBuilder: (context, index) {
                  final item = currentList[index];
                  return foodTile(item["name"], item["img"], item["price"]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getUserDetails() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      final doc = await db.collection("users").doc(uid).get();
      if (doc.exists) {
        debugPrint("User Data: ${doc.data()}");
      } else {
        debugPrint("User not found");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Widget foodTile(String name, String image, String price) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.only(left: 10, top: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.network(
              image,
              height: 150,
              width: 100,
              fit: BoxFit.contain,
              errorBuilder:
                  (context, error, stackTrace) => Icon(Icons.broken_image),
            ),
          ),
          Text(name, style: AppWidget.boldTextFeildStyle()),
          Text("\$$price", style: AppWidget.boldTextFeildStyle()),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => DetailPage(
                            image: image,
                            name: name,
                            price: price,
                          ),
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Color(0xffef2b39),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget categoryTile(String name, String image, String index) {
    final bool isSelected = track == index;
    return GestureDetector(
      onTap: () => setState(() => track = index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(right: 20, bottom: 10),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xffef2b39) : Color(0xFFececf8),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Image.asset(image, height: 40, width: 40, fit: BoxFit.cover),
            SizedBox(width: 10),
            Text(
              name,
              style:
                  isSelected
                      ? AppWidget.whiteTextFeildStyle()
                      : AppWidget.SimpleTextFeildStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
