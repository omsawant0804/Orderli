import 'package:flutter/material.dart';
import 'package:orderli2/Weight/RestoBackend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderli2/CustomerSide/CustomerHome.dart';
import 'package:orderli2/Weight/CustomerBackend.dart';
import 'package:orderli2/Weight/Right_Animation.dart';


class RestoName extends StatefulWidget {
  const RestoName({super.key});

  @override
  State<RestoName> createState() => _RestoNameState();
}

class _RestoNameState extends State<RestoName> {
  TextEditingController name =TextEditingController();
  final RestoBackend _userService = RestoBackend();
  String? email=FirebaseAuth.instance.currentUser?.email.toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFEF6129),
        body: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional(-0.97, -0.25),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                child: Text(
                  'You\'re almost there! 👋' ,
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    color: Color(0xFFFCFBF4),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    color: Colors.transparent,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Container(
                      width: 359,
                      height: 58,
                      decoration: BoxDecoration(
                        color: Color(0xFFF8F7F7),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(16, 2, 10, 0),
                        child: TextFormField(
                          controller: name,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Enter Your Name',
                            hintStyle:
                            TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 18,
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFF040404),
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Align(
              alignment: AlignmentDirectional(0, 0.25),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    color: Colors.transparent,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: GestureDetector(
                      child: Container(
                        width: 339,
                        height: 52,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x33000000),
                              offset: Offset(0, 2),
                            )
                          ],
                          gradient: LinearGradient(
                            colors: [Color(0xFFF8733D), Color(0xFFEEB39A)],
                            stops: [0, 1],
                            begin: AlignmentDirectional(-1, 0.64),
                            end: AlignmentDirectional(1, -0.64),
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                          child: Text(
                            'Check Orderli',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF040404),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      onTap: (){
                        if(name.text.isEmpty){
                          Get.snackbar("Error","Enter Name field!");
                        }else{
                          // _auth.storeUserData(FirebaseAuth.instance.currentUser?.phoneNumber.toString(), name.text.toString());
                          _userService.addRestaurant(name.text.toString(), email);
                        }

                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}
