import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:valor_001/pages/new_activity.dart';
import 'package:valor_001/pages/profile.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valor_001/pages/search.dart';
import 'package:valor_001/pages/team.dart';

import '../main.dart';
import 'feed.dart';
import '../widgets/navigation-bar.dart';
import 'new_group.dart';

Future<void> logOut() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  GoogleSignIn().signOut();
  prefs.setString("photo", "");
  prefs.setString("name", "");
  prefs.setString("loggedIn", "false");
  await FirebaseAuth.instance.signOut();
}

class Home extends StatefulWidget {
  _HomeSplashState createState() => new _HomeSplashState();
}

class _HomeSplashState extends State<Home> {

  @override
  Widget build(BuildContext context) {


    return new SplashScreen(
        seconds: 4,
        navigateAfterSeconds: new HomePage(),
        image: new Image.asset('assets/img/logo-valor.png'),
        backgroundColor: Colors.white,
        photoSize: 100.0,
        loaderColor: Color.fromRGBO(232, 72, 85, 1)
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {

  void refresh (dynamic index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int selectedPage = 0;
  final _pageOptions = [
    Feed(),
    Search(),
    Team(),
    Profile()
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image(image: AssetImage("assets/img/logo-valor.png"), width: 50),
        leading: Builder(
          builder: (context) => GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Icon(
              Icons.menu,
              color: Colors.black,// add custom icons also
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
          padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.notifications_none,
                size: 26.0,
                color: Colors.black,
              ),
            )
          ),
        ],
        elevation: 0,
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: ListTile(
                title: Row(
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Icon(Icons.settings)
                    )
                  ],
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Text(
                    'Log Out',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Icon(Icons.arrow_forward_rounded)
                  )
                ],
              ),
              onTap: () {
                logOut();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
              },
            ),
          ],
        ),
      ),
      body: _pageOptions[_selectedIndex],
      bottomNavigationBar: NavigationBar(notifyParent: refresh),
    );
  }
}

// leading: Icon(
// Icons.ac_unit
// ),
// automaticallyImplyLeading: false,
// backgroundColor: Colors.white,
// toolbarHeight: 70,
// title: Image(image: AssetImage("assets/img/logo-valor.png"), width: 50,),
// centerTitle: true,
// elevation: 0,