import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orderli2/CustomerSide/CustomerHome.dart';
import 'package:orderli2/RestoSide/RestoSetting.dart';
import 'package:orderli2/Weight/CustomerBackend.dart';
import 'package:orderli2/Weight/RestoBackend.dart';
import 'package:orderli2/Weight/Right_Animation.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Map<String, dynamic>? userData;
  final RestoBackend _userService = RestoBackend();

  getdata() async {
    userData = await _userService.getRestoData();
    _populateUserData();
    print(userData);
  }


  Future<void> _populateUserData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Fetch user data from Firestore or any other source
        print(userData?['Name']);
        String name = userData?['Name']; // Replace with actual data retrieval
        String email = userData?['Email']; // Replace with actual data retrieval
        String? Phno = userData?['phoneNumber']==null?'':userData?['phoneNumber'];// Get email from Firebase Auth
        // Update text controllers with user data
        print(name);
        _nameController.text = name;
        _mobileController.text = Phno??'';
        _emailController.text=email;
        setState(() {}); // Update UI
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }


  Future<void> _saveUserData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Get the document reference for the user
        DocumentReference userDocRef = _firestore.collection('Restaurant').doc(user.uid);

        // Prepare the data to be updated
        Map<String, dynamic> updatedUserData = {
          'Name': _nameController.text,
          'phoneNumber': _mobileController.text,
          // Add other fields as needed
        };

        // Update the user data in Firestore
        await userDocRef.update(updatedUserData);

        Navigator.of(context).push(Right_Animation(child: RestaurantProfile(),
            direction: AxisDirection.right));

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User data saved successfully')),
        );
      }
    } catch (error) {
      print('Error saving user data: $error');
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save user data')),
      );
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.only(left: 0), // Adjust the left padding as needed
            child: Text(
              'Profile',
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
                Navigator.of(context).push(Right_Animation(child: RestaurantProfile(),
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
      body: Column(
        children: [
          Divider(
            height: 20,
            color: Color(0xFFEFEBEB),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(19.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Container(
                  //   width: 220,
                  //   height: 60,
                  //   padding: const EdgeInsets.symmetric(horizontal: 12),
                  //   decoration: BoxDecoration(
                  //       color: Color(0xFFEF6129),
                  //       borderRadius: BorderRadius.circular(35),
                  //       boxShadow: [
                  //         BoxShadow(
                  //             //offset: Offset(0, 4),
                  //             color: Color(0xFFF9D276), //edited
                  //             spreadRadius: 4,
                  //             blurRadius: 10 //edited
                  //             )
                  //       ]),
                  //   child: Row(
                  //     children: [
                  //       Icon(
                  //         Icons.account_circle_rounded,
                  //         color: Colors.white,
                  //         size: 50.0,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 30.0),
                  SizedBox(height: 30.0),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  SizedBox(height: 15.0),
                  TextFormField(
                    readOnly: true,
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  SizedBox(height: 15.0),
                  TextFormField(
                    controller: _mobileController,
                    decoration: InputDecoration(
                      labelText: 'Mobile',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  SizedBox(height: 15.0),
                  SizedBox(height: 15.0),
                  ElevatedButton(
                    onPressed: () {
                      // if(validateEmail(_emailController.text)){
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(content: Text('Enter valid email')),
                      //   );
                      // }else{
                      //   _saveUserData();
                      // }
                      _saveUserData();
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEF6129),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
