import 'package:flutter/material.dart';

class AddEditPage extends StatelessWidget {
  TextEditingController txt = TextEditingController();

  String? oldTitle;
  int? index;

  AddEditPage({this.oldTitle, this.index});

  @override
  Widget build(BuildContext context) {
    if (oldTitle != null) {
      txt.text = oldTitle!;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(oldTitle == null ? "Add Task" : "Edit Task"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: txt,
            decoration: InputDecoration(
              labelText: "Enter Task",
            ),
          ),
          ElevatedButton(
            onPressed: () {
              String title = txt.text;

              Navigator.pop(context, {
                "title": title,
                "index": index,
              });
            },
            child: Text("Save"),
          )
        ],
      ),
    );
  }
}