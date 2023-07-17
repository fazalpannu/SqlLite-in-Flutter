import 'package:ch13/card.dart';
import 'package:ch13/cart_dislay.dart';
import 'package:ch13/cart_provider.dart';
import 'package:ch13/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class productlist extends StatefulWidget {
  const productlist({super.key});

  @override
  State<productlist> createState() => _productlistState();
}

class _productlistState extends State<productlist> {
  List<String> fruitNames = ['Apple', 'Banana', 'Orange', 'Grapes'];
  List<String> units = ['kg', 'bunch', 'kg', 'kg'];
  List<int> prices = [2, 1, 1, 3];
  List<String> imageLinks = [
    'https://images.pexels.com/photos/709567/pexels-photo-709567.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/1435735/pexels-photo-1435735.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/616838/pexels-photo-616838.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/2987077/pexels-photo-2987077.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
  ];
  dbhelper _dbhelper = dbhelper();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<cartprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Card'),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => cartdisplay(),
                  ));
            },
            child: Center(
              child: Badge(
                label: Consumer<cartprovider>(
                  builder: (context, value, child) {
                    return Text(value.getcounter().toString());
                  },
                ),
                child: Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: fruitNames.length,
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
                                image: NetworkImage(imageLinks[index]),
                                fit: BoxFit.cover,
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fruitNames[index],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AutofillHints.language),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  units[index] +
                                      '  ' +
                                      r'$' +
                                      prices[index].toString(),
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
                                    onTap: () {
                                      _dbhelper
                                          .insert(Cart(
                                              id: index,
                                              productId: index.toString(),
                                              productName:
                                                  fruitNames[index].toString(),
                                              initialPrice: prices[index],
                                              productPrice: prices[index],
                                              quantity: 1,
                                              unitTag: units[index],
                                              image: imageLinks[index]))
                                          .then((value) {
                                        print('Value Added in Database');
                                        // print(value.toMap().toString());
                                        cart.addtotalprices(double.parse(
                                            prices[index].toString()));
                                        cart.addcounter();
                                      }).onError((error, stackTrace) {
                                        print(error.toString());
                                      });
                                    },
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
                                              fontWeight: FontWeight.w500),
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
          ))
        ],
      ),
    );
  }
}
