import 'package:ch13/card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_provider.dart';

class cartdisplay extends StatefulWidget {
  const cartdisplay({super.key});

  @override
  State<cartdisplay> createState() => _cartdisplayState();
}

class _cartdisplayState extends State<cartdisplay> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<cartprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Card'),
        centerTitle: true,
        actions: [
          Center(
            child: Badge(
              label: Consumer<cartprovider>(
                builder: (context, value, child) {
                  return Text(value.getcounter().toString());
                },
              ),
              child: Icon(Icons.shopping_bag_outlined),
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: cart.getdata(),
            builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                    child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                // ignore: avoid_unnecessary_containers
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 2, color: Colors.white70)),
                                    height: 80,
                                    width: 80,
                                    child: Image(
                                      image: NetworkImage(snapshot
                                          .data![index].image
                                          .toString()),
                                      fit: BoxFit.cover,
                                    )),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data![index].productName
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: AutofillHints.language),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        snapshot.data![index].unitTag
                                                .toString() +
                                            '  ' +
                                            r'$' +
                                            snapshot.data![index].productPrice
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          onTap: () {},
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            height: 30,
                                            width: 80,
                                            child: Center(
                                              child: const Text(
                                                'Add to card',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ));
              } else {
                return Text('Fazal');
              }
            },
          )
        ],
      ),
    );
  }
}
