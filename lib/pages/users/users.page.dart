import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsersPage extends StatefulWidget {
  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late String query;
  bool notVisible = false;
  TextEditingController querryTextEditingController = TextEditingController();
  dynamic data;

  void _search(String query) {
    String url = 'https://api.github.com/search/users?q=${query}&per_page=20&page=0';
    http.get(url as Uri).then((response){
          setState(() {
            this.data = json.decode(response.body);
          });
    }).catchError((error){
          print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('users Page'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                    child: TextFormField(
                      obscureText: notVisible,
                      onChanged: (value){
                        setState(() {
                          this.query = querryTextEditingController.text;
                        });
                      },
                      controller: querryTextEditingController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton( icon:
                            notVisible==true?Icon(Icons.visibility_off): Icon(Icons.visibility),
                          onPressed: () {
                          setState(() {
                            notVisible = !notVisible;
                          });
                        },),
                        contentPadding: EdgeInsets.only(left: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            width: 1, color: Colors.greenAccent
                          ),
                        ),
                      ),
                    ),
                ),
              ),
              IconButton(onPressed: (){
                setState(() {
                  this.query = querryTextEditingController.text;
                  _search(query);
                });

              }, icon: Icon(Icons.search, color: Colors.green,))
            ],
          )
        ],
      )
    );
  }


}