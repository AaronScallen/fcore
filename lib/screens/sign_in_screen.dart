import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_samples/res/custom_colors.dart';
import 'package:flutterfire_samples/screens/user_info_screen.dart';
import 'package:flutterfire_samples/widgets/sign_in_form.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => UserInfoScreen(
            user: user,
          ),
        ),
      );
    }

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _emailFocusNode.unfocus();
        _passwordFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Image.asset(
                          'assets/core.png',
                          height: 160,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'InfoCore',
                        style: TextStyle(
                          color: Colors.blue[500],
                          fontSize: 40,
                        ),
                      ),
                      Text(
                        'NISD Police',
                        style: TextStyle(
                          color: CustomColors.firebaseOrange,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                  future: _initializeFirebase(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error initializing Firebase');
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return SignInForm(
                        emailFocusNode: _emailFocusNode,
                        passwordFocusNode: _passwordFocusNode,
                      );
                    }
                    return CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        CustomColors.firebaseOrange,
                      ),
                    );
                  },
                )
                // SignInForm(
                //   emailFocusNode: _emailFocusNode,
                //   passwordFocusNode: _passwordFocusNode,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
