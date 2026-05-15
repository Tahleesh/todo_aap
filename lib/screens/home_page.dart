import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/user_provider.dart';
import 'add_edit_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();

    getTasks().then((value) {
      setState(() {
        tasks = value;
      });
    });
  }

  Future<List<Task>> getTasks() async {
    List<Task> temp = [];

    String userId = Provider.of<UserProvider>(context, listen: false).userId;

    var url = Uri.parse(
      "http://localhost/todo_api/getTasks.php?user_id=$userId",
    );

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (int i = 0; i < data.length; i++) {
        temp.add(
          Task(
            data[i]['id'].toString(),
            data[i]['title'].toString(),
            int.parse(data[i]['isDone'].toString()),
          ),
        );
      }
    }

    return temp;
  }

  Future<void> deleteTask(String id) async {
    var url = Uri.parse("http://localhost/todo_api/deleteTask.php");

    await http.post(url, body: {"id": id});

    getTasks().then((value) {
      setState(() {
        tasks = value;
      });
    });
  }

  Future<void> addTask(String title) async {
    String userId = Provider.of<UserProvider>(context, listen: false).userId;

    var url = Uri.parse("http://localhost/todo_api/addTask.php");

    await http.post(url, body: {"title": title, "user_id": userId});

    getTasks().then((value) {
      setState(() {
        tasks = value;
      });
    });
  }

  Future<void> updateTask(String id, String title) async {
    var url = Uri.parse("http://localhost/todo_api/updateTask.php");

    await http.post(url, body: {"id": id, "title": title});

    getTasks().then((value) {
      setState(() {
        tasks = value;
      });
    });
  }

  Future<void> toggleTask(String id, int isDone) async {
    var url = Uri.parse("http://localhost/todo_api/toggleTask.php");

    await http.post(url, body: {"id": id, "isDone": isDone == 1 ? "0" : "1"});

    getTasks().then((value) {
      setState(() {
        tasks = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To Do App"), centerTitle: true),

      body: ListView.builder(
        itemCount: tasks.length,

        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(tasks[index].title),

              leading: IconButton(
                icon: Icon(
                  tasks[index].isDone == 1
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                ),

                onPressed: () {
                  toggleTask(tasks[index].id, tasks[index].isDone);
                },
              ),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,

                children: [
                  IconButton(
                    icon: Icon(Icons.edit),

                    onPressed: () async {
                      var result = await Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (context) =>
                              AddEditPage(oldTitle: tasks[index].title),
                        ),
                      );

                      if (result != null) {
                        updateTask(tasks[index].id, result["title"]);
                      }
                    },
                  ),

                  IconButton(
                    icon: Icon(Icons.delete),

                    onPressed: () {
                      deleteTask(tasks[index].id);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
            context,

            MaterialPageRoute(builder: (context) => AddEditPage()),
          );

          if (result != null) {
            addTask(result["title"] );
          }
        },

        child: Icon(Icons.add),
      ),
    );
  }
}
