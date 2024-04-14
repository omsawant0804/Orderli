import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:orderli2/LoginCheck.dart';
import 'package:orderli2/LoginMain.dart';
import 'package:orderli2/NameField.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:orderli2/Weight/Right_Animation.dart';
import 'package:orderli2/main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class CustVerification extends StatefulWidget {
  final String vid;
  final String phno;
  const CustVerification({super.key,required this.vid, required this.phno});

  @override
  State<CustVerification> createState() => _CustVerificationState();
}

class _CustVerificationState extends State<CustVerification> {
  TextEditingController otpText=TextEditingController();
  var code='';
  sigIn()async{
    PhoneAuthCredential credential=PhoneAuthProvider.credential(
        verificationId: widget.vid,
        smsCode: code,
    );

    try{
      await FirebaseAuth.instance.signInWithCredential(credential).then((value){
      Get.offAll(wraper());
      });
      }on FirebaseAuthException catch(e){
      Get.snackbar('Invalid OTP', e.code);
    }catch(e){
      Get.snackbar('Invalid OTP', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFEF6129),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Color(0xFFEF6129),
          automaticallyImplyLeading: false,
          actions: [],
          flexibleSpace: FlexibleSpaceBar(
            title: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 14),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: (){
                              Navigator.of(context).push(Right_Animation(child: MyHomePage(),
                                  direction: AxisDirection.right));
                            },
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            centerTitle: true,
            expandedTitleScale: 1.0,
          ),
          elevation: 0,
        ),
      ),

      body: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(0, -0.85),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 10),
                  child: Text(
                    'OTP\nVerification',
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0xFFF8F7F7),
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),


          Align(
            alignment: AlignmentDirectional(0, -0.50),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'OTP has been send to ',
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0xFFFCFBF4),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    widget.phno,
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0xFFFCFBF4),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: AlignmentDirectional(0, -0.2),
            child: PinCodeTextField(
              controller: otpText,
              autoDisposeControllers: false,
              appContext: context,
              length: 6,
              textStyle: TextStyle(
                fontFamily: 'Readex Pro',
                color: Colors.white,
              ),
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              enableActiveFill: false,
              autoFocus: true,
              enablePinAutofill: false,
              errorTextSpace: 16,
              showCursor: true,
              cursorColor: Color(0xFF040404),
              obscureText: false,
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                fieldHeight: 44,
                fieldWidth: 44,
                borderWidth: 2,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                shape: PinCodeFieldShape.box,
                activeColor: Colors.white,
                inactiveColor: Colors.white,
                selectedColor: Colors.white,
                selectedFillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  code=value;
                });
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              // validator: _model.pinCodeControllerValidator.asValidator(context),
            ),
          ),



          Align(
            alignment: AlignmentDirectional(0, 0.33),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  color: Colors.transparent,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Container(
                    width: 244,
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
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: TextButton(
                        child: Text(
                          'Verify',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFF040404),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: (){
                          sigIn();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),


          Align(
            alignment: AlignmentDirectional(0, 0.74),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Didn\'t get it?',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    color: Color(0xFFFCFBF4),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                  child: Text(
                    'Send OTP (SMS)',
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0xFFFCFBF4),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          )


        ],
      ),
    );
  }
}
