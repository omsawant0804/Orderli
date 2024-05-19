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
      Get.offAll(RestaurantHomePage());
    } catch (error) {
      print('Error adding restaurant: $error');
      // Handle error
    }
  }


  Future<Map<String, dynamic>> getRestoData() async {
    try {
      // Get current user from Firebase Authentication
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Get user document ID
        String documentId = user.uid;
        print(documentId);

        // Get document snapshot from Firestore
        DocumentSnapshot documentSnapshot =
        await _firestore.collection('Restaurant').doc(documentId).get();

        // Check if document exists
        if (documentSnapshot.exists) {
          // Return user data as a map
          return documentSnapshot.data() as Map<String, dynamic>;
        } else {
          throw Exception('Document does not exist');
        }
      } else {
        throw Exception('User is not logged in');
      }
    } catch (error) {
      print('Error getting user data: $error');
      // Handle error
      throw error;
    }
  }

}