import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orderli2/CustomerSide/LoginMain.dart';
import 'package:orderli2/CustomerSide/NameField.dart';
import 'package:orderli2/CustomerSide/OrderHistory.dart';
import 'package:orderli2/CustomerSide/Profile.dart';
import 'package:orderli2/CustomerSide/Scan.dart';
import 'package:orderli2/Weight/CustomerBackend.dart';
import 'package:orderli2/Weight/Right_Animation.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustHome extends StatefulWidget {
  const CustHome({Key? key}) : super(key: key);

  @override
  State<CustHome> createState() => _CustHomeState();
}

class _CustHomeState extends State<CustHome> {
  final String restaurantId = "";
  final user = FirebaseAuth.instance.currentUser;
  final CustBackend _userService = CustBackend();
  Map<String, dynamic>? userData;
  String name = "userName";
  String Phno = "xxx-xxx-xxxx";
  final TextEditingController _name = TextEditingController();
  late Stream<QuerySnapshot> _ordersStream;
  final FirestoreService firestoreService=FirestoreService();


  @override
  void initState() {
    super.initState();
    Check();
    getdata();
    _ordersStream = firestoreService.fetchUserOrders();
  }

  Check() async {
    bool phoneNumberExists = await _userService.checkCurrentUserExists();
    if (!phoneNumberExists) {
      Navigator.of(context).pushReplacement(
          Right_Animation(child: NameField(), direction: AxisDirection.left));
    }
  }

  getdata() async {
    // Fetching user data and updating state
    userData = await _userService.getUserData();
    setState(() {
      name = userData?["Name"];
      Phno = userData?["phnoNumber"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          title: Padding(
            padding: EdgeInsets.only(left: 0),
            child: Text(
              'Hassle Free Orders\n$name,',
              style: TextStyle(
                fontFamily: 'Readex Pro',
                color: Color(0xFF040404),
                fontSize: 20,
              ),
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.only(left: 10),
            child: IconButton(
              color: Color(0xFF040404),
              iconSize: 35,
              onPressed: () {
                Navigator.of(context).push(Right_Animation(
                    child: SecondPage(), direction: AxisDirection.left));
              },
              icon: const Icon(Icons.account_circle_outlined),
            ),
          ),
          backgroundColor: Colors.white,
          flexibleSpace: Container(
            width: 350,
            child: Divider(
              height: 20,
              color: Color(0xFFEFEBEB),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                alignment: Alignment.centerLeft,
                child: Center(
                  child: Text(
                    'Current Orders',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _ordersStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Something went wrong'));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final orders = snapshot.data!.docs;

                    if (orders.isEmpty) {
                      return Center(child: Text('No orders yet'));
                    }

                    return ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final orderData = orders[index].data() as Map<String, dynamic>;

                        if (orderData['status'] == 'Delivered') {
                          // Show dialog and move order to history
                          WidgetsBinding.instance.addPostFrameCallback((_) async {
                            await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Order Delivered'),
                                content: Text('Your order has been delivered.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                            );

                            // Move the order to the history collection
                            FirebaseFirestore.instance
                                .collection('User')
                                .doc(user?.uid)
                                .collection('orderHistory')
                                .doc(orders[index].id)
                                .set(orderData);

                            // Delete the order from the current orders
                            FirebaseFirestore.instance
                                .collection('orders')
                                .doc(orders[index].id)
                                .delete();
                          });
                        }

                        return OrderCard(
                          orderData: orderData,
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 120,),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 5,
            right: 5,
            child: ClipRect(
              child: Container(
                width: 300,
                height: 122,
                decoration: BoxDecoration(
                  color: Color(0xFFFC8019),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70),
                    topRight: Radius.circular(70),
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.zero,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 40.0),
                    SizedBox(
                      width: 180,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QRCodeScreen()),
                          );
                        },
                        child: const Text(
                          'Scan QR Code',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                        ),
                      ),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Map<String, dynamic> orderData;

  const OrderCard({
    Key? key,
    required this.orderData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String restoName = orderData['restoName'];
    final double totalAmount = orderData['totalAmount'] ?? 0.0;
    final Map<String, dynamic> items = orderData['items'];
    final String additionalNote = orderData['additionalNote'] ?? '';
    final String status = orderData['status'] ?? 'Pending';

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Restaurant Name: $restoName',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Total Amount: ₹${totalAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Additional Note: $additionalNote',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Items:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ...items.entries.map((entry) {
              final itemName = entry.key;
              final itemData = entry.value as Map<String, dynamic>;
              final count = itemData['count'];
              final price = itemData['price'];

              return Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$itemName - Count: $count, Price: ₹$price'),
                  ],
                ),
              );
            }).toList(),
            SizedBox(height: 8),
            Text(
              'Status: $status',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}


class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> fetchUserOrders() {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Get the current user's document ID
      String userId = user.uid;

      // Reference to the Order collection
      CollectionReference orders =
      FirebaseFirestore.instance.collection('orders');

      // Return a stream of orders where the userId matches the current user's document ID
      return orders.where('userId', isEqualTo: userId).snapshots();
    } else {
      // If user is not logged in, return an empty stream
      return Stream.empty();
    }
  }
}



// --------------------------------------------------------------------SecondPage------------------------------------------------------------------------------------------------

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  Map<String, dynamic>? userData;
  final CustBackend _userService = CustBackend();
  String name="userName";
  String Phno="xxx-xxx-xxxx";
  final TextEditingController _name = TextEditingController();

  Future<void> signout() async {
    await FirebaseAuth.instance.signOut().then((value) {
      Navigator.of(context).pushReplacement(Right_Animation(
          child: MyHomePage(), direction: AxisDirection.left));

    });

    // AlertDialog(
    //   title: Text('LogOut'),		 // To display the title it is optional
    //   content: Text('Are you sure you want to logout!'), // Message which will be pop up on the screen
    //   // Action widget which will provide the user to acknowledge the choice
    //   actions: [
    //     TextButton(
    //         onPressed:(){
    //
    //         },
    //         child:Text("Cancle"),
    //     ),
    //
    //     TextButton(
    //         onPressed:()async{
    //           await FirebaseAuth.instance.signOut().then((value) {
    //             Navigator.of(context).pushReplacement(Right_Animation(
    //                 child: wraper(), direction: AxisDirection.left));
    //           });
    //         },
    //         child:Text("Ok"),
    //     ),
    //   ],
    // );

  }

  getdata(){

    Future.delayed(Duration(seconds: 0), () async{
      // Assuming user data is fetched here
      userData = await _userService.getUserData();
      setState(() {
        // Assigning dummy data, replace with your actual implementation
        name=userData?["Name"];
        Phno=userData?["phnoNumber"];
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('logout'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel',
                style: TextStyle(
                color: Color(0xFFFC8019),
              ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Perform logout action here
                signout();
                Navigator.of(context).pop();
              },
              child: Text('Logout',
              style: TextStyle(
                color: Color(0xFFFC8019),
              ),
              ),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.only(left: 0), // Adjust the left padding as needed
            child: Text(
              'Settings',
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
                Navigator.of(context).push(Right_Animation(child: CustHome(),
                    direction: AxisDirection.right));
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          backgroundColor: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          Divider(
            height: 20,
            color: Color(0xFFEFEBEB),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 28, 10, 18),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:AssetImage("assets/images/user.png"),
                        backgroundColor: Color(0xFFF4EFE9),
                        radius: 35,
                      ),

                      Padding(
                        padding:EdgeInsetsDirectional.fromSTEB(10, 8, 0, 0),
                        child: Container(
                          width: 150,
                          height: 60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name,
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                color: Color(0xFF040404),
                                fontSize: 20,
                              ),
                              ),
                              Text(Phno,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 10, 10, 0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(Right_Animation(child:  ProfileScreen(),
                          direction: AxisDirection.left));
                    },
                    child: Container(
                      width: 460,
                      height: 70,
                      child: Row(
                        children: [
                          Icon(
                            Icons.account_circle_outlined,
                            size: 30,
                            // color: Color(0xFFFC8019),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Profile"),
                          ),

                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(240, 0 ,0, 0),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 15,
                              color: Color(0xFFFC8019),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                  child: Container(
                    width: 350,
                    child: Divider(
                      height: 8,
                      color: Color(0xFFD3CFCF),
                    ),
                  ),
                ),


                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20,0, 10, 0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(Right_Animation(child: SecondScreen(),
                          direction: AxisDirection.left));
                    },
                    child: Container(
                      width: 360,
                      height: 70,
                      child: Row(
                        children: [
                          Icon(
                            Icons.history_rounded,
                            size: 30,
                            // color: Color(0xFFFC8019),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Order History"),
                          ),

                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(200, 0 ,0, 0),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 15,
                              color: Color(0xFFFC8019),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                  child: Container(
                    width: 350,
                    child: Divider(
                      height: 8,
                      color: Color(0xFFD3CFCF),
                    ),
                  ),
                ),


              ],
            ),
          ),
          // Align(
          //   alignment: AlignmentDirectional(-1,0.78),
          //   child: Container(
          //     child: ListView(
          //       children: [
          //         ListTile(
          //           title: Text(' Edit Profile'),
          //           trailing: Icon(Icons.keyboard_arrow_right_sharp),
          //           onTap: () {
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) => ProfileScreen(),
          //               ),
          //             );
          //           },
          //         ),
          //         ListTile(
          //           title: Text('History'),
          //           trailing: Icon(Icons.keyboard_arrow_right_sharp),
          //           onTap: () {
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) => SecondScreen(),
          //               ),
          //             );
          //           },
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Align(
            alignment: AlignmentDirectional(0, 0),
            child: Container(
              width: 80,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Color(0xFFEFEBEB),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: TextButton(
                child: Text("LogOut",
                style: TextStyle(
                  color: Color(0xFFFC8019),
                ),
                ),
                onPressed: () {
                    // signout();
                  showLogoutDialog(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
