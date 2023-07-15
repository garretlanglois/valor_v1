import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'new_activity.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class RemoveHighlight extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class _FeedState extends State<Feed> with TickerProviderStateMixin{

  var posts = <List<String>>[];

  void checkPosts() async {
    if (posts.length == 0) {
      final prefs = await SharedPreferences.getInstance();
      //Get cached posts
      var cached_posts = prefs.get("Posts");
      if (cached_posts != 0) {
        posts = cached_posts;
      }
      else {
        //Get Posts from the server
      }
    }
    else {
      //Add new posts to the posts list

      //This error may fix itself once the firebase calls are added
    }
  }

  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: Activity()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Color.fromRGBO(246, 81, 29, 0.8),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: ScrollConfiguration(
          behavior: RemoveHighlight(),
          child: ListView.builder(
            itemBuilder: (context, index) {
              if (index < posts.length) {
                // Show your info
                return Text("$index");
              }
              else {
                return Center(child: CircularProgressIndicator());
              }
            },
            itemCount: posts.length + 1,
          ),
        )
      ),
    );
  }
}


