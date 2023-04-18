import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// ignore: must_be_immutable
class GetRepositoriesPage extends StatefulWidget {
  String login;
  String avatarUrl;
  GetRepositoriesPage({super.key, required this.login, required this.avatarUrl});

  @override
  State<GetRepositoriesPage> createState() => _GetRepositoriesPageState();
}


class _GetRepositoriesPageState extends State<GetRepositoriesPage> {
  dynamic dataRepositories;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadRepositories();
  }
  void loadRepositories(){
    String url = 'https://api.github.com/users/${widget.login}/repos';
    http.get(Uri.parse(url)).then((response){
      setState(() {
        dataRepositories = json.decode(response.body);
      });


    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Repositories ${widget.login}'),
        actions: [
          CircleAvatar(backgroundImage: NetworkImage(widget.avatarUrl),)
        ],
      ),
      body: ListView.separated(
          separatorBuilder: (context, index)=> const Divider(height: 2,color: Colors.green,),
          itemCount: dataRepositories==null?0:dataRepositories.length,
          itemBuilder: (context, index) =>
            ListTile(
              title: Text("${dataRepositories[index]['name']}"),
            )
          ,),
    );
  }
}
