import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'home.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFFEFEFEF)),
      home: new Scaffold(
          appBar: AppBar(
          leading: Container( // Draw the return key
              margin: EdgeInsets.all(10), // set margin
              decoration: BoxDecoration(
                color: Colors.white, // Container background color
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0), // Container is set to circle
                ),
              ),
              child: Container(
                margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Close the current page
                  },
                ),
              )
          ),
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: FractionallySizedBox(
          widthFactor: 1,
          heightFactor: 1,
          child: Container(
            color: Colors.white,
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.8,
                            child: Text(
                              "Email:",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.8,
                            child: Container(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(0, 180, 215, 1), width: 3),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(0, 180, 215, 1), width: 3),
                                  ),
                                  hintText: "example@gmail.com"
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an email';
                                  }
                                  bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                                  if (!emailValid) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.8,
                            child: Text(
                              "Password:",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.8,
                            child: Container(
                              child: TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color.fromRGBO(0, 180, 215, 1), width: 3),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color.fromRGBO(0, 180, 215, 1), width: 3),
                                    ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 180, 215, 1),
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: Offset(0, 2)
                                )
                              ]
                            ),
                            child: FlatButton(
                              onPressed: () {
                                // Validate returns true if the form is valid, or false otherwise.
                                if (_formKey.currentState!.validate()) {
                                  Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: Home()));
                                }
                              },
                              child: Text(
                                'Submit',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
