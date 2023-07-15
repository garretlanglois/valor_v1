import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:valor_001/pages/profile.dart';

import '../pages/home.dart';

class NavigationBar extends StatefulWidget {
  final Function(dynamic childVariable) notifyParent;
  NavigationBar ({Key? key, required this.notifyParent}) : super(key: key);
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar > {
  PageController pageController = PageController(
      initialPage: 0,
      keepPage: true,
  );
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    widget.notifyParent(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_sharp, size: 25,),
                title: Text('Home'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search_sharp, size: 25,),
                title: Text("Search")
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.group, size: 25,),
                title: Text("Team")
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_sharp, size: 25,),
                title: Text('Profile'),
            ),
          ],
          showUnselectedLabels: false,
          showSelectedLabels: false,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          iconSize: 20,
          onTap: _onItemTapped,
          elevation: 0
      ),
    );
  }
}