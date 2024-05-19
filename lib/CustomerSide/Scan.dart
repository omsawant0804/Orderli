import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:orderli2/CustomerSide/CustomerHome.dart';
import 'package:orderli2/RestoSide/CustMenu.dart';
import 'package:orderli2/Weight/Right_Animation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScreen extends StatefulWidget {
  @override
  _QRCodeScreenState createState() => _QRCodeScreenState();
}
class _QRCodeScreenState extends State<QRCodeScreen> {
  late QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    String url = ""; // Initialize URL variable

    return Scaffold(
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.only(left: 0),
            child: Text(
              'Scan QR',
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
              iconSize: 25,
              onPressed: () {
                Navigator.of(context).pushReplacement(Right_Animation(child: CustHome(), direction: AxisDirection.right));
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          backgroundColor: Colors.white,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Theme.of(context).primaryColor,
                  borderRadius: 5,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 300,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData != null) {
        _handleResult(context, scanData.code);
        controller.pauseCamera();
      }
    });
  }

  void _handleResult(BuildContext context, String? qrData) async {
    if (qrData?.isNotEmpty == true && qrData!.startsWith("v://app/restaurant-menu")) {
      List<String> parts = qrData.split("="); // Split the QR data to get the document ID
      if (parts.length > 1) {
        String restaurantDocId = parts[1];
        _handleValidRestaurantId(context, restaurantDocId);
      }
    } else {
      // Handle invalid QR code or null qrData
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Invalid QR Code"),
            content: Text("The scanned QR code is not valid for this app."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  controller.resumeCamera();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  void _handleValidRestaurantId(BuildContext context, String restaurantDocId) {
    String url = "v://app/restaurant-menu?id=$restaurantDocId"; // Construct URL with scanned document ID
    // Call function to handle the valid restaurant ID (e.g., navigate to restaurant menu screen)
    // You can also use the URL for generating QR code if needed
    _navigateToRestaurantMenu(context, restaurantDocId);
  }

  void _navigateToRestaurantMenu(BuildContext context, String restaurantDocId) {

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CustomerMenuPage(restaurantDocId),
      ),
    ).then((_) => controller.stopCamera());
    // print(restaurantDocId+"hello");
    // print("Hello");
  }
}



