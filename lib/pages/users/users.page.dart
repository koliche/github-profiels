import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_profils/pages/repositories/repositories.page.dart';
import 'package:http/http.dart' as http;

class UsersPage extends StatefulWidget {
  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late String query;
  bool notVisible = false;
  TextEditingController queryTextEditingController = TextEditingController();
  dynamic data;
  int currentPage = 0;
  int totalPage = 0;
  int pageSize = 20;
  List<dynamic> items = [];
  ScrollController scrollController =ScrollController();

  void _search(String query) {
    String url = 'https://api.github.com/search/users?q=$query&per_page=$pageSize&page=$currentPage';
    http.get(Uri.parse(url)).then((response){
          setState(() {
            data = json.decode(response.body);
            items.addAll(data['items']);
            if(data['total_count'] % pageSize == 0){
              totalPage = data['total_count']~/pageSize;
            }else {
              totalPage = (data['total_count']/pageSize).floor()+1;
            }

          });
    }).catchError((error){
          print(error);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        setState(() {
          if(currentPage<totalPage-1){
            ++currentPage;
            _search(query);
          }

        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('users Page => $currentPage/$totalPage'),
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
                          this.query = queryTextEditingController.text;
                        });
                      },
                      controller: queryTextEditingController,
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
                  items = [];
                  currentPage = 0;
                  this.query = queryTextEditingController.text;
                  _search(query);
                });

              }, icon: Icon(Icons.search, color: Colors.green,))
            ],
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index)=> const Divider(height: 2,color: Colors.green,),
                controller: scrollController,
                itemCount: items.length,
                itemBuilder: (context, index){
                  return ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> GetRepositoriesPage(login: items[index]['login'], avatarUrl: items[index]['avatar_url'],)));
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(items[index]['avatar_url']),
                              radius: 30,
                            ),
                            SizedBox(width: 20,),
                            Text("${items[index]['login']}"),

                          ],
                        ),
                        CircleAvatar(
                          child: Text("${items[index]['score']}"),
                        ),
                      ],
                    ),
                  );
                }),
          )
        ],
      )
    );
  }


}