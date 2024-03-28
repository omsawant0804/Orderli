import 'package:flutter/material.dart';
import 'package:orderli2/LoginMain.dart';
import 'package:orderli2/Weight/Right_Animation.dart';
class RestoLogin extends StatefulWidget {
  const RestoLogin({super.key});

  @override
  State<RestoLogin> createState() => _RestoLoginState();
}

class _RestoLoginState extends State<RestoLogin> {
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
                      EdgeInsetsDirectional.fromSTEB(16, 2, 0, 0),
                      child: TextFormField(
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
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
            alignment: AlignmentDirectional(0, 0.28),
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
                      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                      child: Text(
                        'Continue',
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
                ),
              ],
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-0.97, -0.9),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
              child: Text(
                'Restaurant \nLogin',
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
                'Let\'s check todays order\'s ',
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
            alignment: AlignmentDirectional(-1.31, 0.38),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(70, 20, 0, 0),
              child: Text(
                'Don\'t have account?',
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  color: Color(0xFFFCFBF4),
                  fontSize: 18,
                ),
              ),
            ),
          ),

          Align(
            alignment: AlignmentDirectional(-0.1, 0.38),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(145, 20, 0, 0),

                child: Text(
                  'SignUp',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    color: Color(0xFFFCFBF4),
                    fontSize: 18,
                  ),
                ),

            ),
          ),


        ],
      ),
    );
  }
}
