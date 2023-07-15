import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:valor_001/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valor_001/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() async{
  Paint.enableDithering = true;
  WidgetsFlutterBinding.ensureInitialized();
  var login = await read_loggedIn();
  login = "false";
  await Firebase.initializeApp();
  if (login == "true") {
    runApp(MaterialApp(
        home: Home()
    ));
  }
  else {
    runApp(MaterialApp(
      home: Login(),
    ));
  }
}

Future<String> read_loggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  var value = prefs.getString("loggedIn");
  return value;
}

Future<void> save_loggedIn(GoogleSignInAccount googleUser) async {

  var following;
  final firestoreInstance = FirebaseFirestore.instance;
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("loggedIn", "true");
  prefs.setString("name", googleUser.displayName);
  prefs.setString("email", googleUser.email);
  String email = prefs.getString("email");
  prefs.setString("photo", googleUser.photoUrl);
  print("below");
  firestoreInstance.collection("users").where("email", isEqualTo: email).get().then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((result) {
      print(result.data());
      print("test");
    });
  });
}

class Login extends StatefulWidget {
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  Future<UserCredential> signInWithGoogle() async{

    User? user;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleUser = await googleSignIn.signIn();

    save_loggedIn(googleUser);

    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      final UserCredential userCredential =
      await auth.signInWithCredential(credential);

      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // handle the error here
      }
      else if (e.code == 'invalid-credential') {
        // handle the error here
      }
    } catch (e) {
      // handle the error here
    }
    Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: Home()));
    return await FirebaseAuth.instance.signInWithCredential(credential);


  }

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
            body: Center(
                child: FractionallySizedBox(
                  widthFactor: 1,
                  heightFactor: 1,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          margin: EdgeInsets.fromLTRB(0, 40, 0, 40),
                          child: FractionallySizedBox(
                            widthFactor: 1,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Welcome",
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 50),
                                  ),
                                  Text(
                                    "Start with an account",
                                    style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                  )
                                ]
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          width: 250,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: SignIn()));
                            },
                            child: Text(
                              "Sign In",
                              style: GoogleFonts.montserrat(color: Colors.white, fontSize: 17),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 180, 215, 1),
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(width: 2.0, color: Color.fromRGBO(0, 180, 215, 1)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: Offset(0, 2)
                                )
                              ]
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          width: 250,
                          child: FlatButton(
                              onPressed: () {},
                              child: Text(
                                "Create Account",
                                style: GoogleFonts.montserrat(color: Colors.black, fontSize: 17),
                              ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(width: 2.0, color: Color.fromRGBO(0, 180, 215, 1)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(0, 2)
                              )
                            ]
                          ),
                        ),
                        Container(
                          width: 250,
                          margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                          height: 50,
                          child: SignInButton(
                            Buttons.Google,
                            text: "Sign up with Google",
                            onPressed: () {
                              signInWithGoogle();
                              print("test");
                            },
                          ),
                        ),
                      ]
                    ),
                  ),
                )
            )
        ),
      );
  }
}
