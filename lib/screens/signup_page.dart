import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatelessWidget {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Signup"), centerTitle: true),

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

            TextField(
              controller: txtConfirmPassword,
              obscureText: true,

              decoration: InputDecoration(
                labelText: "Confirm Password",
                border: OutlineInputBorder(),
              ),
            ),

            Container(margin: EdgeInsets.only(top: 20)),

            ElevatedButton(
              onPressed: () async {
                String username = txtUsername.text;
                String password = txtPassword.text;
                String confirmPassword = txtConfirmPassword.text;

                if (password != confirmPassword) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Passwords do not match")),
                  );

                  return;
                }

                var url = Uri.parse("http://localhost/todo_api/signup.php");

                var response = await http.post(
                  url,
                  body: {"username": username, "password": password},
                );

                var data = jsonDecode(response.body);

                if (data["status"] == "success") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Account Created Successfully")),
                  );

                  Navigator.pop(context);
                }
              },

              child: Text("Signup"),
            ),
          ],
        ),
      ),
    );
  }
}
