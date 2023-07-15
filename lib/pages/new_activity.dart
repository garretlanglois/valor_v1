import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gradients/flutter_gradients.dart';

class Activity extends StatefulWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  String dropdownValue = "Select a Stroke";
  bool distance_visible = false;
  bool advanced_visible = false;
  String URL = "";

  void setPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    String photo_url = await prefs.getString("photo");
    setState(() {
      this.URL = photo_url;
    });
  }

  @override
  void initState() {
    super.initState();
    setPreferences();
  }

  Color buttonColor = Color.fromRGBO(0, 180, 216, 1);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Container(
            height: 50,
            width: 50,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                child: Icon(Icons.arrow_back_ios, color: Colors.grey.shade400,),
                margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Post",
            style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 20),
          ),
          centerTitle: true,
          actions: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 14, 20, 14),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,

                          colors: [
                            Color.fromRGBO(178, 254, 250, 1),
                            Color.fromRGBO(14, 210, 247, 1),
                          ],
                          // tileMode: TileMode.clamp
                        )
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                )
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(30),
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                  Spacer(),
                  Container(
                    width: 180,
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 20),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: "Write a post title",
                          hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 20),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      )
                  ),
                  Icon(Icons.create_outlined),
                  Spacer(),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
              // margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              // height: 200,
              // width: 300,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 18),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: "Write a description",
                          hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: Colors.grey.shade300, fontSize: 20),
                          labelStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 20),
                          floatingLabelBehavior: FloatingLabelBehavior.never
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  )
                ),
              ]
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 3, color: Colors.grey.shade300)
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Text(
                        "Details",
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 20),
                    )
                  ),
                  Row(
                    children: [
                      Spacer(),
                      DropdownButton<String>(
                        hint: Text(dropdownValue),
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 15),
                        underline: Container(height: 0,),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                            distance_visible = true;
                          });
                        },
                        items: <String>['Butterfly', 'Backstroke', 'Breastroke', 'Freestyle']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      Visibility(
                        maintainSize: false,
                        visible: distance_visible,
                        child: Spacer(),
                      ),
                      AnimatedOpacity(
                        opacity: distance_visible ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 500),
                        child: Visibility(
                          maintainSize: false,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: distance_visible,
                          child: Container(
                            width: 100,
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: "Distance",
                                hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: Colors.grey.shade600, fontSize: 15),
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 15),
                            )
                          ),
                        ),
                      ),
                      Spacer()
                    ]
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: FractionallySizedBox(
          widthFactor: .9,
          child: Container(
            height: 60,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
            decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 1)
                  )
                ],
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,

                  colors: [
                    Color.fromRGBO(178, 254, 250, 1),
                    Color.fromRGBO(14, 210, 247, 1),
                  ],
              )
            ),
            child: FlatButton (
              onPressed: () {
                setState(() {
                  showTopSnackBar(
                      context,
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 70,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 180, 216, 1),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5,
                                spreadRadius: 3,
                                color: Colors.grey.shade400.withOpacity(0.8)
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Icon(Icons.check,
                                color: Colors.white, size: 25,),
                            ),
                            Container(
                              child: Center(
                                child: Text("Your post was created successfully",
                                  style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15, decoration: TextDecoration.none,),
                                  textAlign: TextAlign.center,),
                              ),
                            ),
                          ],
                        ),
                      )
                  );
                });
              },
              child: Center(
                child: Text("Post",
                  style: GoogleFonts.montserrat(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
