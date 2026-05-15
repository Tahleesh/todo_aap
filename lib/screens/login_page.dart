import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'signup_page.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"), centerTitle: true),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: txtUsername,

              decoration: InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
            ),

            Container(margin: EdgeInsets.only(top: 20)),

            TextField(
              controller: txtPassword,
              obscureText: true,

              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),

            Container(margin: EdgeInsets.only(top: 20)),

            ElevatedButton(
              onPressed: () async {
                String username = txtUsername.text;
                String password = txtPassword.text;

                var url = Uri.parse("http://localhost/todo_api/login.php");

                var response = await http.post(
                  url,

                  body: {"username": username, "password": password},
                );

                var data = jsonDecode(response.body);

                if (data["status"] == "success") {
                  Provider.of<UserProvider>(
                    context,
                    listen: false,
                  ).setUserId(data["user_id"].toString());

                  Navigator.push(
                    context,

                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Username or Password incorrect")),
                  );
                }
              },

              child: Text("Login"),
            ),

            Container(margin: EdgeInsets.only(top: 20)),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },

              child: Text("Create New Account"),
            ),
          ],
        ),
      ),
    );
  }
}
