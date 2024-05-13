import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:orderli2/CustomerSide/CustomerHome.dart';
import 'package:orderli2/RestoSide/CustMenu.dart';
import 'package:orderli2/Weight/Right_Animation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code Scanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QRCodeScreen(),
    );
  }
}

class QRCodeScreen extends StatefulWidget {
  @override
  _QRCodeScreenState createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  final String restaurantId = "123"; // Replace with your restaurant ID
  late QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Create the URL with the custom format
    String url = "v://app/restaurant-menu?id=$restaurantId";

    return Scaffold(
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.only(left: 0), // Adjust the left padding as needed
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
            padding: EdgeInsets.only(left: 10), // Adjust the left padding as needed
            child: IconButton(
              color: Color(0xFF040404),
              iconSize: 25,
              onPressed: () {
                Navigator.of(context).pushReplacement(Right_Animation(child: CustHome(),
                    direction: AxisDirection.right));
                Navigator.of(context).pop();
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //ElevatedButton(
          // onPressed: () {
          //   _scanQR(context);
          //  },
          // child: Text('Scan QR Code'),
          // ),



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

  void _scanQR(BuildContext context) async {
    String qrResult = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666", // Color for the scan button
      "Cancel", // Text for the cancel button
      false, // Whether to show flash icon
      ScanMode.QR, // Scan mode (QR, BARCODE, PDF417, etc.)
    );

    // Check if the QR code scan was successful
    if (qrResult != "-1") {
      _handleResult(context, qrResult);
    } else {
      // Handle scan failure or cancellation
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("QR Code Scan Failed"),
            content: Text("Failed to scan the QR code."),
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

  void _handleResult(BuildContext context, String? qrData) {
    // Check if qrData is null or empty
    if (qrData?.isNotEmpty == true && qrData!.startsWith("v://app/restaurant-menu")) {
      // Extract restaurant ID from the QR data
      List<String> parts = qrData.split("=");
      if (parts.length > 1) {
        String restaurantId = parts[1];

        // Navigate to the restaurant menu screen with the extracted ID
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantMenuScreen(restaurantId: restaurantId),
          ),
        ).then((_) => controller.resumeCamera());
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

  String generateQRCode(String url) {
    // Replace this with your custom QR code generation logic
    return "https://api.qrserver.com/v1/create-qr-code/?data=$url&size=200x200";
  }
}




class RestaurantMenuScreen extends StatefulWidget {
  final String restaurantId;

  const RestaurantMenuScreen({required this.restaurantId});

  @override
  _RestaurantMenuScreenState createState() => _RestaurantMenuScreenState();
}

class _RestaurantMenuScreenState extends State<RestaurantMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            centerTitle: true,
            title: Padding(
              padding: EdgeInsets.only(left: 0), // Adjust the left padding as needed
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
              padding: EdgeInsets.only(left: 10), // Adjust the left padding as needed
              child: IconButton(
                color: Color(0xFF040404),
                iconSize: 25,
                onPressed: () {
                  Navigator.of(context).push(Right_Animation(child: CustHome(),
                      direction: AxisDirection.right));
                  Navigator.of(context).pop();
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
        body: CustomerMenuPage(),
      ),
    );
  }
}