import 'package:flutter/material.dart';
import 'package:sqlite_demo/local_database.dart';
import 'package:sqlite_demo/user.model.dart';

class UserUIDemo extends StatefulWidget {
  const UserUIDemo({super.key});

  @override
  State<UserUIDemo> createState() => _UserUIDemoState();
}

class _UserUIDemoState extends State<UserUIDemo> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: "User Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                await LocalDatabaseApi.insertData(
                  User(
                    userName: _textEditingController.text,
                  ),
                );
                _textEditingController.clear();
                setState(() {

                });
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
