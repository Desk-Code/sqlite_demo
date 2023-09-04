import 'package:flutter/material.dart';
import 'package:sqlite_demo/local_database.dart';
import 'package:sqlite_demo/user.model.dart';

class UserUIDemo extends StatefulWidget {
  const UserUIDemo({super.key});

  @override
  State<UserUIDemo> createState() => _UserUIDemoState();
}

class _UserUIDemoState extends State<UserUIDemo> {
  //

  final TextEditingController _textEditingController = TextEditingController();
  late Future<List<User>> futureUserData;
  bool isUpdate = false;
  int? selectedId;

  @override
  void initState() {
    futureUserData = LocalDatabaseApi.selectData();
    super.initState();
  }

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
              onPressed: isUpdate
                  ? () async {
                      User obj = User(
                        id: selectedId,
                        userName: _textEditingController.text,
                      );
                      await LocalDatabaseApi.updateData(obj);
                      futureUserData = LocalDatabaseApi.selectData();
                      _textEditingController.clear();
                      isUpdate = false;
                      setState(() {});
                    }
                  : () async {
                      await LocalDatabaseApi.insertData(
                        User(
                          userName: _textEditingController.text,
                        ),
                      );
                      futureUserData = LocalDatabaseApi.selectData();
                      _textEditingController.clear();
                      isUpdate = false;
                      setState(() {});
                    },
              child: Text(isUpdate ? "Update" : "Submit"),
            ),
            FutureBuilder(
              future: futureUserData,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          LocalDatabaseApi.deleteData(
                            snapshot.data![index].id!,
                          );
                          futureUserData = LocalDatabaseApi.selectData();
                          _textEditingController.clear();
                          isUpdate = false;
                          setState(() {});
                        },
                        child: ListTile(
                          title: Text(snapshot.data![index].userName),
                          trailing: Text("${DateTime.now()}"),
                          onTap: () {
                            _textEditingController.text =
                                snapshot.data![index].userName;
                            selectedId = snapshot.data![index].id;
                            isUpdate = true;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Text("There is no Data...");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
