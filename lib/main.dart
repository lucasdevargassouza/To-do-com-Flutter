import 'package:flutter/material.dart';
import 'package:to_do/pages/HomePage.dart';


/* 
  Ao iniciar a app é executado primeiramente uma função que chama a tela inicial!
*/
void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To do',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}
