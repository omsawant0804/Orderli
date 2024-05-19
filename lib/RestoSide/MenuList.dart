import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:orderli2/RestoSide/AddMenu.dart';
import 'package:orderli2/RestoSide/RestoProfile.dart';
import 'package:orderli2/RestoSide/RestoSetting.dart';
import 'package:orderli2/Weight/Right_Animation.dart';
class MenuListPage extends StatefulWidget {
  @override
  _MenuListPageState createState() => _MenuListPageState();
}

class _MenuListPageState extends State<MenuListPage> {
  final user = FirebaseAuth.instance.currentUser;
  final _currencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
  // String restoId="restaurantId123";
  String restoId="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    restoId=user!.uid.toString();
    print(restoId);
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
              'Menu',
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
          backgroundColor: Colors.white,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Restaurant').doc(restoId).collection('Menu').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                // Ensure that price is interpreted as a double
                double price = data['price'] is double ? data['price'] : (data['price'] as num).toDouble();
                return MenuItemCard(
                  documentId: document.id,
                  itemName: data['itemName'],
                  description: data['description'],
                  price: _currencyFormat.format(price),
                  imageUrl: data['imageUrl'],
                  onDelete: () async {
                    await FirestoreService().deleteMenuItem(restoId, document.id, data['imageUrl']);
                  },
                  onEdit: () {
                    _editMenuItem(context, document.id, data['itemName'], data['description'], price, data['imageUrl']);
                  },
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }

  void _editMenuItem(BuildContext context, String documentId, String itemName, String description, double price, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController itemNameController = TextEditingController(text: itemName);
        final TextEditingController descriptionController = TextEditingController(text: description);
        final TextEditingController priceController = TextEditingController(text: price.toString());

        File? newImageFile;

        return AlertDialog(
          title: Text('Edit Menu Item'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: itemNameController,
                  decoration: InputDecoration(labelText: 'Item Name'),
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final picker = ImagePicker();
                    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      newImageFile = File(pickedFile.path);
                    }
                  },
                  child: Text('Replace Image'),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      final updatedItemName = itemNameController.text;
                      final updatedDescription = descriptionController.text;
                      final updatedPrice = double.tryParse(priceController.text) ?? 0.0;

                      if (updatedItemName.isNotEmpty && updatedDescription.isNotEmpty && updatedPrice > 0) {
                        if (newImageFile != null) {
                          MenuItem updatedMenuItem = MenuItem(
                            itemName: updatedItemName,
                            description: updatedDescription,
                            price: updatedPrice,
                            imageUrl: imageUrl, // Reuse the old image URL if no new image is selected
                          );
                          await FirestoreService().updateMenuItem(restoId, documentId, updatedMenuItem, newImageFile);
                        } else {
                          // If no new image is selected, update only other details
                          MenuItem updatedMenuItem = MenuItem(
                            itemName: updatedItemName,
                            description: updatedDescription,
                            price: updatedPrice,
                            imageUrl: imageUrl, // Reuse the old image URL
                          );
                          await FirestoreService().updateMenuItem(restoId, documentId, updatedMenuItem, null);
                        }

                        Navigator.of(context).pop(); // Close the dialog
                      } else {
                        // Show an error dialog if any field is empty or price is not valid
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('Please enter valid input for all fields.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEF6129), // Set background color
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Adjust spacing between icon and text
                        Text(
                          'Update Menu Item',
                          style: TextStyle(color: Colors.white), // Set text color
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MenuItemCard extends StatelessWidget {
  final String documentId;
  final String itemName;
  final String description;
  final String price;
  final String imageUrl;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  MenuItemCard({
    required this.documentId,
    required this.itemName,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                imageUrl,
                height: 270,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      color: Colors.white, // Dark white color
                      onPressed: onEdit,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.white, // Dark white color
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price: $price',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}