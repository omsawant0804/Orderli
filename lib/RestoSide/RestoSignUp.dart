import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orderli2/RestoSide/RestoHome.dart';
import 'package:orderli2/RestoSide/RestoLogin.dart';
import 'package:orderli2/Weight/Firebase_auth.dart';
import 'package:orderli2/Weight/Right_Animation.dart';
import 'package:get/get.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';


class RestoSignUP extends StatefulWidget {
  const RestoSignUP({super.key});

  @override
  State<RestoSignUP> createState() => _RestoSignUPState();
}

class _RestoSignUPState extends State<RestoSignUP> {
  FirebaseAuthService _auth=FirebaseAuthService();
  TextEditingController emailController=TextEditingController();
  TextEditingController PassController=TextEditingController();
  TextEditingController confirmPassController=TextEditingController();
  var _isObscured = true;


  bool validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? true
        : false;
  }


  bool isPasswordCompliant(String password, [int minLength = 6]) {
    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    bool hasSpecialCharacters = password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length > minLength;

    return !(hasDigits && hasUppercase && hasLowercase && hasSpecialCharacters && hasMinLength);
  }

  bool validateCnPass(){
    if(PassController.text != confirmPassController.text){
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    PassController.dispose();
    confirmPassController.dispose();
    super.dispose();
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
                              Icons.arrow_back_ios_new_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: (){
                              Navigator.of(context).push(Right_Animation(child: RestoLogin(),
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
            alignment: AlignmentDirectional(0, -0.32),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  color: Colors.transparent,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Container(
                    width: 359,
                    height: 58,
                    decoration: BoxDecoration(
                      color: Color(0xFFF8F7F7),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(16, 2, 0, 0),
                      child: TextFormField(
                        controller: emailController,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Enter emailId',
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
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),



          Align(
            alignment: AlignmentDirectional(0, -0.04),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  color: Colors.transparent,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Container(
                    width: 359,
                    height: 58,
                    decoration: BoxDecoration(
                      color: Color(0xFFF8F7F7),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(16, 2, 10, 0),
                      child: TextFormField(
                        controller: PassController,
                        autofocus: true,
                        obscureText: _isObscured,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isObscured = !_isObscured;
                              });
                            },
                            child: _isObscured
                                ? const Icon(
                              Icons.visibility_off, color: Colors.grey,)
                                : const Icon(
                              Icons.visibility, color: Colors.grey,),
                          ),
                          hintText: 'Enter Password',
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
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),


          Align(
            alignment: AlignmentDirectional(0, 0.25),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  color: Colors.transparent,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Container(
                    width: 359,
                    height: 58,
                    decoration: BoxDecoration(
                      color: Color(0xFFF8F7F7),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(16, 2, 0, 0),
                      child: TextFormField(
                        controller: confirmPassController,
                        autofocus: true,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Enter Confirm Password',
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
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),









          Align(
            alignment: AlignmentDirectional(0, 0.55),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  color: Colors.transparent,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: GestureDetector(
                    child: Container(
                      width: 349,
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
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                        child: Text(
                          'SignUp',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFF040404),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    onTap: (){
                      if(emailController.text.isEmpty || PassController.text.isEmpty || confirmPassController.text.isEmpty){
                        Get.snackbar("Error","Enter required field");
                      } else if(validateEmail(emailController.text)){
                        Get.snackbar("Error","Invalid email address");
                      }else if(isPasswordCompliant(PassController.text)) {
                        Get.snackbar("Password should contain : ",
                            "minLength: 6\nuppercaseChar\nlowercaseChar\nnumericChar\nspecialChar");
                      }else if(validateCnPass()){
                        Get.snackbar("Error","Password doesn't match");
                      }else{
                        SignUp();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-0.97, -0.9),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
              child: Text(
                'Restaurant \nSignUp',
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  color: Color(0xFFFCFBF4),
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-0.97, -0.57),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
              child: Text(
                'Let\'s connect customer',
                style: TextStyle(
                  // fontFamily: 'Readex Pro',
                  color: Color(0xFF040403),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),


          Align(
            alignment: AlignmentDirectional(-1.31, 0.65),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(70, 20, 0, 0),
              child: Text(
                'Already have an account?',
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  color: Color(0xFFFCFBF4),
                  fontSize: 18,
                ),
              ),
            ),
          ),

          Align(
            alignment: AlignmentDirectional(-0.0, 0.65),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(210, 70, 0, 0),

              child: TextButton(
                onPressed: (){
                  Navigator.of(context).push(Right_Animation(child: RestoLogin(),
                      direction: AxisDirection.right));
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    color: Color(0xFFFCFBF4),
                    fontSize: 18,
                  ),
                ),
              ),

            ),
          ),


        ],
      ),
    );
  }

  void SignUp()async{
    String email=emailController.text;
    String Pass=PassController.text;

    User? user= await _auth.signUpWithEmailAndPassword(email, Pass);

    if(user != null){
      Get.snackbar("SignUp Successfully","please login");
      Navigator.of(context).push(Right_Animation(child: RestoLogin(),
          direction: AxisDirection.left));
    }

  }
}
