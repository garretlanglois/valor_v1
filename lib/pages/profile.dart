import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoveHighlight extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formkey = GlobalKey<FormState>();
  String URL = "";
  String name = "";
  String location = "unset";

  //Write logic to check if the viewed user is favourited or not
  Icon currentStar = Icon(Icons.star_border_outlined);
  Icon notFavourite = Icon(Icons.star_border_outlined);
  Icon favourite = Icon(Icons.star);

  void setPreferences() async{
    final prefs = await SharedPreferences.getInstance();
    String photo_url = await prefs.getString("photo");
    String profile_name = await prefs.getString("name");
    String home = await prefs.getString("location");
    setState(() {
      this.URL = photo_url;
      this.name = profile_name;
      this.location = home;
    });
  }

  @override
  void initState() {
    super.initState();
    setPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.shade200,
        child: ScrollConfiguration(
          behavior: RemoveHighlight(),
          child: ListView(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3)
                    )
                  ]
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(30,0,0,0),
                  child: Row(
                    children: [
                      Container(
                        height: 65,
                        width: 65,
                        child: Builder(
                          builder: (context) {
                            if (URL != "") {
                              return CircleAvatar(backgroundImage: NetworkImage(URL));
                            }
                            else {
                              return CircleAvatar(child:FlatButton(
                                onPressed: () => {},
                                padding: EdgeInsets.all(20),
                                child: Column( // Replace with a Row for horizontal icon + text
                                  children: <Widget>[
                                    Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 23,
                                    ),
                                  ],
                                ),
                              ),
                              backgroundColor: Color.fromRGBO(232, 72, 85, 1),
                              );
                            }
                          }
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                name,
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(2)
                            ),
                            Container(
                              child: Builder(
                                builder: (context) {
                                  if (location == null) {
                                    return Container(
                                      height: 25,
                                      width: 100,
                                      child: FlatButton(
                                        padding: EdgeInsets.all(3),
                                        onPressed: () {},
                                        child: Text(
                                            "Set Location",
                                          style: GoogleFonts.montserrat(color: Colors.black, fontWeight: FontWeight.w500),
                                        ),
                                        color: Colors.greenAccent,
                                      ),
                                    );
                                  }
                                  else {
                                    return Text(location);
                                  }
                                }
                              ),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      FlatButton(
                          onPressed: () {
                            setState(() {
                              if (currentStar == favourite) {
                                currentStar = notFavourite;
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'User removed from favourites',
                                        style: GoogleFonts.montserrat(color: Colors.black),
                                      ),
                                      duration: Duration(milliseconds: 1000),
                                      backgroundColor: Colors.white,
                                      action: SnackBarAction(
                                        label: "Undo",
                                        textColor: Color.fromRGBO(0, 180, 215, 1),
                                        onPressed: () {},
                                      ),
                                      width: 310,
                                      padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(40)
                                      ),
                                      elevation: 1,
                                    )
                                );
                              }
                              else {
                                currentStar = favourite;
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'User added to favourites',
                                        style: GoogleFonts.montserrat(color: Colors.black),
                                      ),
                                      duration: Duration(milliseconds: 1000),
                                      backgroundColor: Colors.white,
                                      action: SnackBarAction(
                                        label: "Undo",
                                        textColor: Color.fromRGBO(0, 180, 215, 1),
                                        onPressed: () {},
                                      ),
                                      width: 280,
                                      padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40)
                                      ),
                                      elevation: 1,
                                    )
                                );
                              }
                            });
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: currentStar
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 300,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 3)
                      )
                    ]
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(30, 30, 0, 0),
                      child: Row(
                        children: [
                          Text(
                            "Personal Bests",
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ]
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      height: 200,
                    ),
                    Container(
                      height: 20,
                    )
                  ],
                )
              ),
              Container(
                  height: 100,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 3)
                        )
                      ]
                  )
              ),
              Container(
                  height: 200,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 3)
                        )
                      ]
                  ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(30, 30, 0, 0),
                      child: Text(
                        "Team",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      height: 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 2)
                            )
                          ]
                        ),
                      ),
                    ),
                    Spacer()
                  ],
                ),
              ),
            ]
          ),
        ),
      )
    );
  }
}

//NetworkImage(URL)