import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orderli2/NameField.dart';

class CustHome extends StatefulWidget {
  const CustHome({super.key});

  @override
  State<CustHome> createState() => _CustHomeState();
}

class _CustHomeState extends State<CustHome> {
  final user=FirebaseAuth.instance.currentUser;
  signout()async{
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFEF6129),
      body: Center(
        child: TextButton(
          child: Text("LogOut",
          style: TextStyle(
              fontSize: 30,
              color: Colors.black,
          ),
          ),
          onPressed: (){
            signout();
          },
        )
      ),
    );
  }
}
