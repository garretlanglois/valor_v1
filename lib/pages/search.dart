import 'package:flutter/material.dart';


class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(0, 180, 215, 1), width: 3),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(0, 180, 215, 1), width: 3),
                          ),
                          hintText: "Search..."
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Search something';
                        }
                        return null;
                      },
                    ),
                  ),
                  Icon(
                    Icons.search_sharp
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
