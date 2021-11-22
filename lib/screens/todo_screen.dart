import 'package:flutter/material.dart';
import 'package:todoey_app_shared_pref/model/task_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'dart:convert';

class ToDoScreen extends StatefulWidget {
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  String? task;

  List<TaskData> taskList = [];

  SharedPreferences? prefs;

  void loadData() async {
    prefs = await SharedPreferences.getInstance();

    var json;

    json = prefs!.getString('test_task');
    print(jsonDecode(json));
    var jsonDecoded = jsonDecode(json);

    for (var item in jsonDecoded) {
      print(item['taskText']);
      setState(() {
        taskList.add(TaskData(taskText: item['taskText']));
      });
    }
  }

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //final testTask = TaskData(taskText: "kek", isCheked: false);

    String json = jsonEncode(taskList);
    prefs.setString('test_task', json);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Todo App"),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      onChanged: (value) {
                        task = value;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          taskList.add(TaskData(taskText: task!));
                          saveData();
                          print(taskList);
                        });
                      },
                      child: Text("Add"),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Text(taskList[index].taskText),
                      trailing: Checkbox(
                        value: taskList[index].isCheked,
                        onChanged: (isChecked) {
                          setState(() {
                            isChecked = taskList[index].toggle();
                          });
                        },
                      ),
                    );
                  },
                  itemCount: taskList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
