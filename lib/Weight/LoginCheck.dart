import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orderli2/CustomerSide/CustomerHome.dart';
import 'package:orderli2/CustomerSide/LoginMain.dart';
import 'package:orderli2/RestoSide/RestoHome.dart';

class wraper extends StatefulWidget {
  const wraper({super.key});

  @override
  State<wraper> createState() => _wraperState();
}

class _wraperState extends State<wraper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            if(snapshot.data?.phoneNumber != null){
              return CustHome();
            }else if(snapshot.data?.email!=null){
              return RestaurantHomePage();
            }else{
              return const MyHomePage();
            }
          }
      ),
    );
  }
}
