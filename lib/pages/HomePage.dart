import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do/models/Item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  List<Item> itens = new List<Item>();

  HomePage() {
    itens = [];
    /* itens.add(Item(title: "Item 1", done: false));
    itens.add(Item(title: "Item 2", done: false));
    itens.add(Item(title: "Item 3", done: false)); */
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var newTaskCtrl = TextEditingController();

  void add() {
    if (newTaskCtrl.text == "") return;
    setState(() {
      widget.itens.add(Item(title: newTaskCtrl.text, done: false));
      save();
    });
    newTaskCtrl.clear();
  }

  void remove(int index) {
    setState(() {
      widget.itens.removeAt(index);
      save();
    });
  }

  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Item> result = decoded.map((x) => Item.fromJson(x)).toList();
      setState(() {
        widget.itens = result;
      });
    }
  }

  void save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(widget.itens));
  }

  void change(bool value, int index) {
    setState(() {
      widget.itens[index].done = value;
      save();
    });
  }

  _HomePageState() {
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: TextFormField(
            controller: newTaskCtrl,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            decoration: InputDecoration(
                labelText: "Nova tarefa",
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: add,
            child: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.itens.length,
        itemBuilder: (BuildContext context, int index) {
          final item = widget.itens[index];
          return Dismissible(
            key: Key(item.title),
            child: CheckboxListTile(
              title: Text(item.title),
              value: item.done,
              onChanged: (value) => change(value, index),
            ),
            background: Container(
              color: Colors.red.withOpacity(0.7),
            ),
            onDismissed: (direction) {
              remove(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
