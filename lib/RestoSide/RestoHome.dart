import 'package:flutter/material.dart';
import 'package:orderli2/RestoSide/AddMenu.dart';
import 'package:orderli2/RestoSide/RestoName.dart';
import 'package:orderli2/RestoSide/RestoProfile.dart';

import '../Weight/RestoBackend.dart';
import '../Weight/Right_Animation.dart';


class RestaurantHomePage extends StatefulWidget {
  const RestaurantHomePage({super.key});

  @override
  State<RestaurantHomePage> createState() => _RestaurantHomePageState();
}

class _RestaurantHomePageState extends State<RestaurantHomePage> {
  final RestoBackend _userService = RestoBackend();
  Check() async {
    bool emailExists = await _userService.checkCurrentRestoExists();
    if (!emailExists) {
      Navigator.of(context).pushReplacement(
          Right_Animation(child: RestoName(), direction: AxisDirection.left));
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Check();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome Restaurant',
          style: TextStyle(
            fontFamily: 'RobotoMono',
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          color: Colors.black,
          iconSize: 30,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RestaurantProfile()),
            );
          },
          icon: const Icon(Icons.account_circle_outlined),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              SizedBox(height: 20),
              OrderDetailsCard(
                itemName: 'Pizza',
                quantity: 2,
                tableNumber: 5,
                additionalRequirements: 'Extra cheese',
                totalPrice: 30.0,
              ),
              SizedBox(height: 20),
              OrderDetailsCard(
                itemName: 'Burger',
                quantity: 1,
                tableNumber: 7,
                additionalRequirements: 'No onions',
                totalPrice: 15.0,
              ),
              SizedBox(height: 20),
              OrderDetailsCard(
                itemName: 'Garlic Bread',
                quantity: 1,
                tableNumber: 7,
                additionalRequirements: 'No onions',
                totalPrice: 15.0,
              ),

              // Add more OrderDetailsCard widgets as needed
            ],
          ),
        ),
      ),
    );
  }
}


class OrderDetailsCard extends StatelessWidget {
  final String itemName;
  final int quantity;
  final int tableNumber;
  final String additionalRequirements;
  final double totalPrice;

  const OrderDetailsCard({
    Key? key,
    required this.itemName,
    required this.quantity,
    required this.tableNumber,
    required this.additionalRequirements,
    required this.totalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Card(
        elevation: 0, // Set elevation to 0 for the Card inside the container
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Item: $itemName',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 6),
              Text(
                'Quantity: $quantity',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 6),
              Text(
                'Table Number: $tableNumber',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 6),
              Text(
                'Additional Requirements: $additionalRequirements',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 6),
              Text(
                'Total Price: ₹${totalPrice.toStringAsFixed(2)}', // Replace $ with ₹
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddMenuItemScreen(),
    );
  }
}
