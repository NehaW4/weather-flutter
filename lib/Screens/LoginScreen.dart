import 'package:flutter/material.dart';
import 'package:flutter_gdsc/Components/textfield.dart';
import '../Components/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'mainscreen.dart';
import '../Constants.dart' as constant;
import '../Location.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email, password;
  int myVar = 1;

  @override
  void initState() {
    super.initState();
    apiCall();
  }

  void apiCall() async {
    var location = await determinePosition();
    myVar = await constant.apiInstance.getLocation(
        location.latitude.toString(),
        location.longitude.toString()
    );
  }

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    return Scaffold(
      backgroundColor: constant.textPrimary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Container()),
          Container(
              height: 150,
              child: Image.network('https://cdn.pixabay.com/photo/2017/12/26/21/19/circle-3041437__480.jpg')),
          textfield(
            text: 'Email',
            isPassword: false,
            onChanged: (value) { email = value; },),
          textfield(
            text: 'Password',
            isPassword: true,
            onChanged: (value) { password = value; },),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              width: 100,
              color: constant.textSecondary,
              child: TextButton(
                // style: TextButton.styleFrom(
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(30),
                //     side: BorderSide(
                //       color: constant.textSecondary,
                //       width: 2,
                //     )
                //   ),
                // ),
                onPressed: () async {
                  try {
                    final newUser = await _auth.signInWithEmailAndPassword(
                      email: email, password: password
                    );

                    // print(newUser.toString());

                    if (newUser.user != null && myVar != 0) {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => MainScreen()));
                    }
                  } catch (e) {
                    debugPrint('&e');
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: constant.textPrimary,
                  ),
                ),
              ),
            ),
          ),
          Expanded(child: Container()),
        ],
      )
    );
  }
}