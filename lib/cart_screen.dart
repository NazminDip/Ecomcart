import 'package:app_cart/product_model.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key, this.cList});
  List<ProductModel>? cList = [];

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var netTotal;
  void getTotal() {
    netTotal = widget.cList!
        .map((item) => item.price!.toInt() * item.quantity)
        .reduce((value, element) => value + element);
  }

  @override
  void initState() {
    widget.cList!.length > 0 ? getTotal() : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Total Item is ${widget.cList!.length}"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: widget.cList!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              "${widget.cList![index].image}",
                              height: 80,
                              width: 80,
                            ),
                            Text("${widget.cList![index].name}"),
                            Text(
                                "${widget.cList![index].price! * widget.cList![index].quantity} "),
                            Text("${widget.cList![index].quantity}"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: () {
                                      widget.cList![index].quantity > 0
                                          ? widget.cList![index].quantity--
                                          : widget.cList!.removeAt(index);
                                      getTotal();
                                      setState(() {});
                                    },
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.red,
                                    )),
                                InkWell(
                                    onTap: () {
                                      widget.cList![index].quantity++;
                                      getTotal();
                                      setState(() {});
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.orange,
                                    )),
                                InkWell(
                                    onTap: () {
                                      widget.cList!.removeAt(index);
                                      getTotal();
                                      setState(() {});
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ],
                            )
                          ],
                        ),
                      );
                    })),
            Container(
              height: 80,
              width: double.infinity,
              color: Colors.blue,
              child: Center(
                  child: Text(
                "Total Price is ${netTotal} ",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              )),
            )
          ],
        ),
      ),
    );
  }
}
