import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orderli2/RestoSide/AddMenu.dart';
import 'package:orderli2/RestoSide/MenuList.dart';
import 'package:orderli2/RestoSide/RestoHome.dart';
import 'package:orderli2/RestoSide/RestoLogin.dart';
import 'package:orderli2/Weight/Right_Animation.dart';

class RestaurantProfile extends StatefulWidget {
  const RestaurantProfile({Key? key}) : super(key: key);

  @override
  State<RestaurantProfile> createState() => _RestaurantProfileState();
}

class _RestaurantProfileState extends State<RestaurantProfile> {

  void signOutFirebase(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // You can also perform any additional clean-up or navigation here if needed
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(Right_Animation(child: RestoLogin(),
          direction: AxisDirection.left));
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Log Out'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFFFC8019),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Call the signOutFirebase function here
                signOutFirebase(context);
              },
              child: Text(
                'Log Out',
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
      appBar:PreferredSize(
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
                Navigator.of(context).push(Right_Animation(child: RestaurantHomePage(),
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
                        backgroundImage:AssetImage("assets/images/restaurant.png"),
                        backgroundColor: Color(0xFFF4EFE9),
                        radius: 35,
                      ),

                      // Padding(
                      //   padding:EdgeInsetsDirectional.fromSTEB(10, 8, 0, 0),
                      //   child: Container(
                      //     width: 150,
                      //     height: 60,
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text(name,
                      //           style: TextStyle(
                      //             fontFamily: 'Readex Pro',
                      //             color: Color(0xFF040404),
                      //             fontSize: 20,
                      //           ),
                      //         ),
                      //         Text(Phno,
                      //           style: TextStyle(
                      //             color: Colors.grey,
                      //           ),
                      //         ),
                      //
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),

              GestureDetector(
                onTap: (){
                  // Navigator.of(context).push(Right_Animation(child: AddMenuItemScreen(),
                  //     direction: AxisDirection.left));
                },
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20,0, 10, 0),
                          child: Container(
                            width: 360,
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
                                  padding: EdgeInsetsDirectional.fromSTEB(245, 0 ,0, 0),
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0),
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
              ),

                GestureDetector(
                onTap: (){
                  Navigator.of(context).push(Right_Animation(child: AddMenuItemScreen(),
                      direction: AxisDirection.left));
                },
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20,0, 10, 0),
                          child: Container(
                            width: 360,
                            height: 70,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.dining_outlined,
                                  size: 28,
                                  // color: Color(0xFFFC8019),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Add Dish"),
                                ),

                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(230, 0 ,0, 0),
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0),
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
              ),

                GestureDetector(
                onTap: (){
                  Navigator.of(context).push(Right_Animation(child: MenuListPage(),
                      direction: AxisDirection.left));
                },
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20,0, 10, 0),
                          child: Container(
                            width: 360,
                            height: 70,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.restaurant_menu_outlined,
                                  size: 28,
                                  // color: Color(0xFFFC8019),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Menu"),
                                ),

                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(250, 0 ,0, 0),
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0),
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
              ),


              ],
            ),
          ),

          Align(
            alignment: AlignmentDirectional(-0.01, 0.25),
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
                child: Text("Log Out",
                  style: TextStyle(
                    color: Color(0xFFFC8019),
                  ),
                ),
                onPressed: () {
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