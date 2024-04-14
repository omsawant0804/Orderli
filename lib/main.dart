import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:orderli2/LoginCheck.dart';
import 'package:orderli2/LoginMain.dart';
// import 'package:fluttertoast/fluttertoast.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(
      apiKey: "AIzaSyBdJQdQtGqc578pZWE_FJQQ-jBKwsZx55M",
      appId: "1:99816942728:android:350b8ffe13a8b2ac81433d",
      messagingSenderId: "99816942728",
      projectId: "backendfororderli",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Orderli',
      home:wraper(),
    );
  }
}

