import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderli2/CustVerification.dart';
import 'package:orderli2/RestoLogin.dart';
import 'package:orderli2/Weight/Right_Animation.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController mobile=TextEditingController();
  SendCode()async{
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91'+mobile.text,
          verificationCompleted: (PhoneAuthCredential credential){},
          verificationFailed: (FirebaseAuthException e){
          Get.snackbar('Error Occured', e.code);
          },
          codeSent: (String vid,int? token){
          Get.to(CustVerification(vid: vid,phno: '+91 '+mobile.text,),);
          },
          codeAutoRetrievalTimeout: (vid){}
      );
    }on FirebaseAuthException catch(e){
      Get.snackbar('Error Occured', e.code);
    }catch(e){
      Get.snackbar('Error Occured', e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFEF6129),
      body:Stack(
        children: [
          //DesignContainer1
          Align(
            alignment: AlignmentDirectional(1.51, 0.2),
            child: Container(
              width: 185,
              height: 185,
              decoration: BoxDecoration(
                color: Color(0xFFF86E37),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Color(0x33000000),
                    offset: Offset(0, 0),
                    spreadRadius: 10,
                  )
                ],
                shape: BoxShape.circle,
              ),
            ),
          ),
          //DesignContainer2
          Align(
            alignment: AlignmentDirectional(-2.74, 1.24),
            child: Container(
              width: 222,
              height: 222,
              decoration: BoxDecoration(
                color: Color(0xFFF86E37),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Color(0x33000000),
                    offset: Offset(4, 0),
                    spreadRadius: 0,
                  )
                ],
                shape: BoxShape.circle,
              ),
            ),
          ),
          //DegineContainer3
          Align(
            alignment: AlignmentDirectional(-4.61, -1.81),
            child: Container(
              width: 374,
              height: 374,
              decoration: BoxDecoration(
                color: Color(0xFFF86E37),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Color(0x33000000),
                    offset: Offset(0, 10),
                  )
                ],
                shape: BoxShape.circle,
              ),
            ),
          ),
          //Logo..
          Align(
            alignment: AlignmentDirectional(-1.06, -0.5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/logo.png',
                width: 265,
                height: 118,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Align(
            alignment: AlignmentDirectional(-0.73, -0.32),
            child: Text(
              'Scan & Order',
              style: TextStyle(
                fontFamily: 'Open Sans',
                color: Color(0xFF040404),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Generated code for this Row Widget...
          Align(
            alignment: AlignmentDirectional(0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Material(
                  color: Colors.transparent,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.easeIn,
                    width: 350,
                    height: 58,
                    decoration: BoxDecoration(
                      color: Color(0xFFF8F7F7),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x33000000),
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: Text(
                            '+91',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF040404),
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Form(
                            key: formKey,
                            autovalidateMode: AutovalidateMode.disabled,
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 5),
                              child: TextFormField(
                                controller: mobile,
                                validator: (val){
                                  if(mobile.text.length != 10){
                                    // Tost---> for showing error
                                    // Fluttertoast.showToast(msg: "Please enter valid number",
                                    // toastLength: Toast.LENGTH_LONG,
                                    //   gravity: ToastGravity.TOP,
                                    //   backgroundColor: Colors.red,
                                    //   textColor: Colors.white,
                                    //   timeInSecForIosWeb: 2,
                                    //   fontSize: 18,
                                    // );
                                    return "Please enter valid number";
                                  }
                                  return null;
                                },
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Enter Phone number',
                                  isCollapsed:true,
                                  hintStyle:
                                  TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 18,
                                  ),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                ),
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xFF040404),
                                  fontSize: 18,
                                ),
                                maxLength: 10,
                                buildCounter: (context,
                                    {required currentLength,
                                      required isFocused,
                                      maxLength}) =>
                                null,
                                keyboardType: TextInputType.phone,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),


          Align(
            alignment: AlignmentDirectional(0, 0.21),
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
                    width: 359,
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
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: TextButton(
                          child: Text('Continue',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF040404),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: ()async{
                            if(formKey.currentState!.validate()){
                              // Navigator.of(context).push(Right_Animation(child: CustVerification(),
                              //     direction: AxisDirection.left));
                              SendCode();
                            }

                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),


          Align(
            alignment: AlignmentDirectional(0, 0.33),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(40, 0, 0, 0),
                  child: Text(
                    'Are you restaurant?',
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0xFFFCFBF4),
                      fontSize: 18,
                    ),
                  ),
                ),

                TextButton(
                      child: Text(
                        'Click here',
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          color: Color(0xFFFCFBF4),
                          fontSize: 18,
                        ),
                      ),
                      onPressed: (){
                        Navigator.of(context).push(Right_Animation(child: RestoLogin(),
                            direction: AxisDirection.left));
                      },
                    ),

              ],
            ),
          ),
          //Tems & Conditionwala Text...
          Align(
            alignment: AlignmentDirectional(0, 0.90),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'By continuing, you agree to our\n           Terms & Conditions ',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 14,
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
