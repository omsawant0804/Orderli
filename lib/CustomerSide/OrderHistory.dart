import 'package:flutter/material.dart';
import 'package:orderli2/CustomerSide/CustomerHome.dart';
import 'package:orderli2/Weight/Right_Animation.dart';


void main() {
  runApp(MyApp());
}

class Order {
  final int orderNumber;
  final String date;
  final List<String> items;
  final String status; // New field for order status

  Order({
    required this.orderNumber,
    required this.date,
    required this.items,
    required this.status, // Initialize status in the constructor
  });
}

class OrderCard extends StatefulWidget {
  final Order order;

  OrderCard({required this.order});

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Order Number: ${widget.order.orderNumber}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'Date: ${widget.order.date}',
            ),
            SizedBox(height: 5.0),
            Text(
              'Status: ${widget.order.status}', // Display order status
            ),
            SizedBox(height: 10.0),
            Text(
              'Items:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.order.items
                  .map((item) => Text('- $item'))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  // Sample order data
  final List<Order> orders = List.generate(
    10,
        (index) => Order(
      orderNumber: index + 1,
      date: 'April ${(index + 1)}, 2024',
      items: List.generate(
        (index + 1) % 3 + 1,
            (itemIndex) => 'Item ${(index + 1) * (itemIndex + 1)}',
      ),
      status: _getStatus(index), // Call a function to get status based on index
    ),
  );

  // Function to get status based on index
  static String _getStatus(int index) {
    if (index % 4 == 0) {
      return 'Order Placed';
    } else if (index % 4 == 1) {
      return 'Order Prepared';
    } else if (index % 4 == 2) {
      return 'Order Served';
    } else {
      return 'Order Paid';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.only(left: 0), // Adjust the left padding as needed
            child: Text(
              'Order History',
              style: TextStyle(
                fontFamily: 'Readex Pro',
                color: Color(0xFF040404),
                fontSize: 20,
              ),
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.only(left: 10), // Adjust the left padding as needed
            child: IconButton(
              color: Color(0xFF040404),
              iconSize: 25,
              onPressed: () {
                Navigator.of(context).push(Right_Animation(child: SecondPage(),
                    direction: AxisDirection.right));
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          backgroundColor: Colors.white, // Your original background color
          // flexibleSpace: Container(
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [Color(0xFFEC7142), Color(0xffedeaea)],
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //     ),
          //   ),
          // ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return OrderCard(order: orders[index]);
          },
        ),
      ),
    );
  }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order History App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondScreen()),
            );
          },
          child: Text('View Order History'),
        ),
      ),
    );
  }
}