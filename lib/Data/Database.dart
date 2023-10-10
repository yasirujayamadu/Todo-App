import 'package:hive_flutter/adapters.dart';

class ToDoDataBase {
  List todolist = [];

  //reference our box
  final _myBox = Hive.box('mybox');

  //runthis methodif this the first time app is open
  void createIntitialData() {
    todolist = [
      ["Make a run", false],
      ["Go to see the movie ", false],
    ];
  }

  //load the daatbase\
  void loaData() {
    todolist = _myBox.get("TODOLIST");
  }

  // Update the database
  void updateData() {
    _myBox.put("TODOLIST", todolist);
  }
}
