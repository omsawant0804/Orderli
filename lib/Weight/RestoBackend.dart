import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orderli2/CustomerSide/CustomerHome.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:orderli2/RestoSide/RestoHome.dart';
class RestoBackend{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<bool> checkCurrentRestoExists() async {
    try {
      // Get current user from Firebase Authentication
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Get user document ID
        String documentId = user.uid;

        // Query Firestore to see if document exists
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('Restaurant')
            .doc(documentId)
            .get();

        // Return true if document exists, false otherwise
        return documentSnapshot.exists;
      } else {
        // User is not logged in
        return false;
      }
    } catch (error) {
      print('Error checking current user: $error');
      // Return false in case of any error
      return false;
    }
  }


  // Future<void> addRestaurant(String? name, String? email) async {
  //   try {
  //     User? user = FirebaseAuth.instance.currentUser;
  //     String? documentId = user?.uid;
  //
  //     // Add new restaurant document to Firestore
  //     await _firestore.collection('Restaurant').doc(documentId).set({
  //       'Name': name,
  //       'Email': email,
  //       // Add other restaurant data fields as needed
  //     }).then((value) {
  //       // After adding successfully, navigate to restaurant's home screen
  //       Get.offAll(RestaurantHomePage());
  //     });
  //   } catch (error) {
  //     print('Error adding restaurant: $error');
  //     // Handle error
  //   }
  // }


  Future<void> addRestaurant(String? name, String? email) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String? documentId = user?.uid;

      // Add new restaurant document to Firestore
      DocumentReference restaurantRef =
      FirebaseFirestore.instance.collection('Restaurant').doc(documentId);
      await restaurantRef.set({
        'Name': name,
        'Email': email,
        // Add other restaurant data fields as needed
      });

      // Create subcollection "Menu" with auto-generated document IDs
      // CollectionReference menuRef = restaurantRef.collection('Menu');
      // await menuRef.add({
      //   // You can add initial menu items or other data here if needed
      // });

      // After adding successfully, navigate to restaurant's home screen
      Get.offAll(RestaurantHomePage());
    } catch (error) {
      print('Error adding restaurant: $error');
      // Handle error
    }
  }

}