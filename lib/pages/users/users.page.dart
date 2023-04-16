import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late String query;
  bool notVisible = false;
  TextEditingController querryTextEditingController = TextEditingController();

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
                });

              }, icon: Icon(Icons.search, color: Colors.green,))
            ],
          )
        ],
      )
    );
  }
}