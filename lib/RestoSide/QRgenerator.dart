import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeGeneratorScreen extends StatefulWidget {
  const QRCodeGeneratorScreen({super.key});
  @override
  State<QRCodeGeneratorScreen> createState() => _QRCodeGeneratorScreenState();
}

class _QRCodeGeneratorScreenState extends State<QRCodeGeneratorScreen> {
String restoId="";
final user = FirebaseAuth.instance.currentUser;
  String url = "v://app/restaurant-menu?id=";

  String generateQRCode(String url) {
    // Replace this with your custom QR code generation logic
    return "https://api.qrserver.com/v1/create-qr-code/?data=$url&size=200x200";
  }



  Future<void> generatePdfWithQRCode(String url) async {
    final pdf = pw.Document();

    final qrCode = await _generateQRCodeImage(url);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Image(pw.MemoryImage(qrCode), width: 200, height: 200),
                pw.SizedBox(height: 20),
                pw.Text('Restaurant ID: $restoId', style: pw.TextStyle(fontSize: 24)),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }


  Future<Uint8List> _generateQRCodeImage(String url) async {
    final qrValidationResult = QrValidator.validate(
      data: url,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );

    if (qrValidationResult.status == QrValidationStatus.valid) {
      final qrCode = qrValidationResult.qrCode!;
      final painter = QrPainter.withQr(
        qr: qrCode,
        color: const Color(0xFF000000),
        gapless: true,
      );
      final picData = await painter.toImageData(200);
      return picData!.buffer.asUint8List();
    } else {
      throw Exception('QR code generation failed');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    restoId=user!.uid.toString();
    url = "v://app/restaurant-menu?id=$restoId";
    print(restoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate QR Code'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(generateQRCode(url)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await generatePdfWithQRCode(url);
              },
              child: Text('Generate PDF with QR Code'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}