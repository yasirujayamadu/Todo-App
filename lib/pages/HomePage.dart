import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/Data/Database.dart';
import 'package:todo_app/Uti/dialog_box.dart';
import '../Uti/Todo_tiles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive
  final _myBox = Hive.openBox('mybox');
  ToDoDataBase db = ToDoDataBase();
  void initState() async {
    final box = await Hive.openBox('mybox');

    if (box.get("TODOLIST") == null) {
      db.createIntitialData();
    }
    super.initState();
  }

  //text controller
  final _controller = TextEditingController();

  //method for checkbox
  void CheckboxChanged(bool? value, int index) {
    setState(() {
      db.todolist[index][1] = !db.todolist[index][1];
    });
  }

  //save new task
  void saveNewtask() {
    setState(() {
      db.todolist.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  void creatnewtask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewtask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.todolist.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text('TO DO'),
        elevation: 2,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: creatnewtask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.todolist.length,
        itemBuilder: (context, index) {
          return TodoList(
            taskname: db.todolist[index][0],
            taskcompleted: db.todolist[index][1],
            onChanged: (value) => CheckboxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
