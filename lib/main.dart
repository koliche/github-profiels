import 'package:flutter/material.dart';
import 'package:github_profils/pages/users/users.page.dart';

import 'pages/home/home.page.dart';

void main()=>runApp(const myApp());


class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      routes: {
        '/':(context) => HomePage(),
        '/users': (context) => UsersPage()
      },
      initialRoute: '/users',
    );
  }
}
