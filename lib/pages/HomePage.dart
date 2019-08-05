import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do/models/Item.dart';

class HomePage extends StatefulWidget {
  var itens = new List<Item>();

  HomePage() {
    itens = [];
    itens.add(Item(title: "Item 1", done: false));
    itens.add(Item(title: "Item 2", done: false));
    itens.add(Item(title: "Item 3", done: false));
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var newTaskCtrl = TextEditingController();

  void add() {
    if (newTaskCtrl.text == "") return;
    setState(() {
      widget.itens.add(
        Item(title: newTaskCtrl.text, done: false),
      );
    });
    newTaskCtrl.clear();
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

          return CheckboxListTile(
            title: Text(item.title),
            value: item.done,
            key: Key(item.title),
            onChanged: (value) {
              setState(() {
                item.done = value;
              });
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
