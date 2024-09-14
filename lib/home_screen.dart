import 'package:app_cart/cart_screen.dart';
import 'package:app_cart/product_model.dart';
import 'package:flutter/material.dart';

class HomeScreenEcom extends StatefulWidget {
  const HomeScreenEcom({super.key});

  @override
  State<HomeScreenEcom> createState() => _HomeScreenEcomState();
}

class _HomeScreenEcomState extends State<HomeScreenEcom> {
  List<ProductModel> cartList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Total Product is ${cartList.length}"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Image.asset(
                            "${productList[index].image}",
                            height: 110,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                          Text("${productList[index].name}"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("${productList[index].price}"),
                              InkWell(
                                  onTap: () {
                                    try {
                                      cartList.firstWhere((element) =>
                                          element.id == productList[index].id);
                                      showDialog(
                                          context: (context),
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text("Alert!"),
                                              content: const Text(
                                                  "Data already added"),
                                              contentTextStyle: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child:
                                                        const Text("Cancel")),
                                              ],
                                            );
                                          });
                                    } catch (e) {
                                      cartList.add(productList[index]);
                                      setState(() {});
                                    }
                                  },
                                  child: const Icon(
                                    Icons.shopping_cart,
                                    color: Colors.orange,
                                  ))
                            ],
                          ),
                          Text(
                            "${productList[index].details}",
                            maxLines: 1,
                          ),
                        ],
                      );
                    })),
            MaterialButton(
              color: Colors.blue,
              height: MediaQuery.of(context).size.height * 0.1,
              minWidth: double.infinity,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (cotext) => CartScreen(cList: cartList)));
              },
              child: const Text(
                "Go to Cart Page",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
